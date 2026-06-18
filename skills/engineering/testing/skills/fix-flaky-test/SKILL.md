---
name: fix-flaky-test
description: Use when a test passes and fails non-deterministically without code changes — to identify the root cause category (timing, shared state, concurrency, external dependency, randomness) and eliminate the flakiness rather than retrying or skipping the test.
source: Listfield "Where do our flaky tests come from?" (Google Testing Blog, 2017); Google "Flaky Tests at Google and How We Mitigate Them" (2016); Luo et al. "An Empirical Analysis of Flaky Tests" (FSE, 2014)
tags: [flaky-tests, test-reliability, ci, non-determinism, test-isolation, concurrency, timing, testing]
---

# Fix Flaky Test

Quarantine the flaky test, identify the non-determinism root cause from the six categories, and eliminate it — rather than retrying, skipping, or ignoring.

## Why This Is Best Practice

**Adopted by:** Google publishes its flaky test management methodology publicly (Google Testing Blog, 2016–2022); Microsoft, Netflix, Spotify, and Meta each have internal flaky test detection and quarantine systems; Google's Test Infrastructure team built automated flaky test detection into Google's CI; the academic study of flaky tests (Luo et al., FSE 2014) is the foundational empirical research, analyzed 201 flaky tests across 51 open source projects
**Impact:** Google (2016): 16% of all test failures at Google are caused by flaky tests — not product bugs; flaky tests cause developers to re-run CI 40% more often than in codebases with low flakiness rates; Luo et al. (FSE 2014): 45% of flaky tests are caused by async wait issues and test order dependency — both fixable with deterministic patterns; Netflix (2019): reducing flaky test rate from 5% to < 0.5% reduced developer "ignore and re-run" behavior by 70% and improved defect detection confidence
**Why best:** Retrying flaky tests masks the non-determinism without fixing it — retry loops consume CI time and train developers to distrust test failures; skipping flaky tests removes coverage permanently; the only productive response is elimination; flaky tests that are not fixed accumulate — Google data shows flaky tests grow at 1.5× the rate of new tests if not actively managed

Sources: Listfield "Where do our flaky tests come from?" (Google Testing Blog, 2017); Google "Flaky Tests at Google and How We Mitigate Them" (Google Testing Blog, 2016); Luo, Hariri, Eloussi & Marinov "An Empirical Analysis of Flaky Tests" (FSE, 2014); Micco "Flaky Tests at Google" (Google Testing Blog, 2017)

## Steps

### 1. Quarantine the flaky test immediately

Before diagnosing, quarantine the test so it stops blocking CI without losing coverage tracking:

```python
# Python (pytest) — mark as quarantined, not skipped
@pytest.mark.flaky(reruns=0)    # do NOT use reruns — masks the problem
@pytest.mark.quarantine          # custom marker; tracks quarantined tests
def test_something_flaky():
    ...
```

```javascript
// Jest — move to a separate quarantine suite
// quarantine.test.js (excluded from main CI run, included in a separate flaky-detection job)
describe.skip('QUARANTINED', () => {
  it('something flaky', () => { ... });
});
```

```java
// JUnit 5
@Tag("quarantine")
@Test
void somethingFlaky() { ... }
```

**Quarantine rules:**
- Track quarantined tests in a dedicated label/tag — they must be visible, not silently excluded
- Set a maximum quarantine period: 2 weeks; if not fixed, escalate or delete
- Quarantined tests do not block CI but still run in a separate non-blocking job to detect recurrence

**Do NOT:** add `@Retry(3)` / `--retries` / `flake_tolerance`. Retries mask the flakiness, increase CI time, and prevent the root cause from being found.

### 2. Reproduce the flakiness deterministically

Before fixing, reproduce the failure reliably:

```bash
# Run the test 50 times and observe the failure rate
for i in $(seq 50); do pytest tests/test_foo.py::test_something -x 2>&1 | tail -1; done | sort | uniq -c

# OR: use pytest-repeat
pytest tests/test_foo.py::test_something --count=50
```

If you cannot reproduce failure in 50 runs, the test may have been a one-time infrastructure flake (network timeout, resource contention). Monitor for recurrence before investing in diagnosis.

If you CAN reproduce in 50 runs, proceed to root cause identification.

### 3. Identify the root cause category

Luo et al. (FSE 2014) categorize 45% of flaky tests as async/timing or order-dependency issues. Check each category:

---

**Category 1: Async / timing dependency**

Symptom: test passes locally, fails in CI; failure rate increases under load.

```python
# Problem: fixed sleep instead of waiting for condition
time.sleep(2)
assert element.is_visible()   # fails if render takes > 2s

# Fix: wait for condition explicitly
wait.until(lambda: element.is_visible(), timeout=10)
```

```javascript
// Problem: not awaiting async operation
const result = fetchData();    // returns Promise, not value
expect(result).toBe('done');   // always fails or always passes by accident

// Fix: await
const result = await fetchData();
expect(result).toBe('done');
```

Signs: test includes `sleep()`, `setTimeout()`, fixed delays; test passes on fast machines, fails on slow CI.

---

**Category 2: Test order dependency / shared state**

Symptom: test passes in isolation (`pytest -k test_name`) but fails in the full suite.

```bash
# Diagnose: run the full suite with --randomly-seed=LAST to repeat exact order
pytest --randomly-seed=last

# Find which test contaminates state
pytest --randomly-seed=last -p no:randomly    # disable random, find fixed-order failure
```

Root causes:
- Global/module-level state mutated by a preceding test and not reset
- Database records left by a previous test that conflict with this test's expectations
- File system artifacts (temp files, config files) not cleaned up
- Singleton objects with accumulated state

Fix patterns:
```python
# Setup/teardown to isolate state
@pytest.fixture(autouse=True)
def reset_global_cache():
    cache.clear()
    yield
    cache.clear()

# Use transactions that roll back after each test (database tests)
@pytest.fixture
def db_session():
    session = Session()
    session.begin()
    yield session
    session.rollback()
    session.close()
```

---

**Category 3: Concurrency / race condition**

Symptom: test involves threads, async tasks, or parallel execution; fails intermittently with assertion errors or deadlocks.

```python
# Problem: test reads shared state while another thread writes
def test_counter():
    counter.increment()         # thread A
    assert counter.value == 1  # may read between increment calls if B also increments

# Fix: synchronize before asserting
def test_counter():
    counter.increment()
    counter.wait_for_completion()  # barrier
    assert counter.value == 1
```

If the production code has a race condition that the test is exposing: fix the production code, not just the test.

---

**Category 4: External dependency / network**

Symptom: test calls real network, file system, or clock; fails when service is slow or unavailable.

```python
# Problem: real HTTP call in unit test
def test_user_creation():
    response = requests.post('https://api.service.com/users', ...)
    assert response.status_code == 201

# Fix: mock the external dependency
def test_user_creation(requests_mock):
    requests_mock.post('https://api.service.com/users', status_code=201)
    response = create_user(...)
    assert response.status_code == 201
```

Exception: integration tests that intentionally call real services should run in a separate suite with retry tolerance — not mixed into the unit test suite.

---

**Category 5: Resource leak / environment pollution**

Symptom: test fails only after the test suite has been running for a while; OOM errors; file descriptor exhaustion.

Diagnosis:
```bash
# Monitor resource usage during test run
pytest tests/ --tb=short 2>&1 | grep -E "ResourceWarning|MemoryError|Too many open files"
```

Fix: ensure all resources are closed in teardown:
```python
@pytest.fixture
def temp_file():
    f = open('test.tmp', 'w')
    yield f
    f.close()
    os.unlink('test.tmp')     # always clean up
```

---

**Category 6: Randomness / non-deterministic data**

Symptom: test uses `random`, `uuid`, `datetime.now()`, or shuffled collections.

```python
# Problem: test depends on random order
items = get_items()          # returns items in random order
assert items[0].name == 'Alice'    # fails when order changes

# Fix: sort before asserting, or use set comparison
assert {item.name for item in items} == {'Alice', 'Bob'}
```

```python
# Fix: seed random in tests
import random
random.seed(42)
```

### 4. Apply the fix and verify elimination

After fixing:

```bash
# Run 100 times to confirm flakiness is gone
pytest tests/test_foo.py::test_something --count=100
```

All 100 runs must pass. If failure rate drops but doesn't reach 0%, the fix is incomplete — the root cause has multiple contributing factors.

### 5. Remove from quarantine and add to CI

After 100 clean runs:
1. Remove the quarantine marker
2. Add the test back to the main CI run
3. Commit the fix with a message that names the root cause: `test: fix flaky test_something — async timing dependency`

### 6. Prevent recurrence in the same area

After fixing, look for the same pattern in adjacent tests:

```bash
# Find all tests using fixed sleeps (common source of timing flakiness)
grep -rn "time.sleep\|setTimeout" tests/

# Find all tests not using db transactions (order-dependency risk)
grep -rn "def test_" tests/integration/ | grep -v "db_session"
```

File a follow-up ticket to address the pattern, not just the instance.

## Rules

- Quarantine immediately; never retry — retries mask flakiness and consume CI time
- Reproduce in 50+ runs before diagnosing — confirms the flakiness is real, not a one-time infrastructure flake
- Quarantine maximum 2 weeks — if not fixed, escalate or delete; quarantine is not permanent parking
- Fix at the root cause category, not at the symptom — adding a sleep to fix a timing test adds a new timing dependency
- Verify with 100 clean runs after the fix — a fix that reduces failure rate from 20% to 5% is not a fix
- Commit test fix with the root cause in the message — future readers need to know why it was changed

## Common Mistakes

- **Adding `@Retry(3)` as the "fix"**: reduces visible failures at the cost of 2–3× CI time and zero improvement in code quality; the flakiness remains and will resurface as the suite grows
- **`time.sleep(5)` to fix a timing issue**: adds a 5-second fixed delay; the test still fails when the system is slower than 5 seconds under load; use condition-wait with timeout instead
- **Skipping the test permanently**: removes coverage; the bug that the test would have caught gets shipped; quarantine ≠ permanent skip
- **Fixing the test without checking for the pattern**: fixing `test_order_list` for shared state contamination without checking `test_order_create`, `test_order_update` — the same fixture anti-pattern exists in 3 other tests; find and fix the pattern
- **Not reproducing before fixing**: assuming the root cause category without verifying; writing a "fix" that doesn't address the actual source of non-determinism

## When NOT to Use

- Tests that fail due to a genuine product bug introduced by a code change — this is not flakiness, it's a regression; use `write-regression-test` and `bisect-regression` instead
- Infrastructure-level flakiness (CI runner runs out of memory, network timeout to artifact registry) — this is ops/infra work, not test design work; file with the infrastructure team

