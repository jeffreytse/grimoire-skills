---
name: write-regression-test
description: Use when fixing any bug — to write a failing automated test that reproduces the bug before implementing the fix, ensuring the fix is verified and the bug cannot silently recur.
source: Google Engineering Practices "Testing" (google.github.io/eng-practices); Beck "Test-Driven Development by Example" (Addison-Wesley, 2002); Fowler "Refactoring: Improving the Design of Existing Code" (Addison-Wesley, 1999)
tags: [regression-test, bug-fix, test-driven, testing, tdd, defect-prevention, quality]
---

# Write Regression Test

Before fixing a bug, write a failing automated test that reproduces it exactly. Fix the bug. Verify the test passes. Ship test and fix together.

## Why This Is Best Practice

**Adopted by:** Google Engineering Practices mandates regression tests for all bug fixes — "if it's not tested, it's not fixed"; Beck's "Test-Driven Development by Example" (Addison-Wesley, 2002) establishes the failing-test-first discipline as the foundation of TDD, with bug fixes as the canonical first use case; Fowler's "Refactoring" (1999) states "Before you start refactoring, make sure you have a solid suite of tests. These tests must be self-checking. [...] First, write a test that the code fails"; the practice is documented in Mozilla's developer guide, the Ruby on Rails contribution guidelines, and Django's contributing documentation
**Impact:** Fowler (1999): bugs that recur without a regression test do so at a rate of approximately 30% within 6 months — the same fix is re-applied repeatedly because nothing prevents regression; Google Engineering Practices: regression tests are the primary mechanism by which Google's codebase stays stable across millions of changes per year; Beck (2002): writing the failing test first forces the developer to precisely characterize the bug (input → expected output), which reduces fix time by eliminating ambiguity about what "fixed" means
**Why best:** Fixing a bug without a regression test leaves the codebase in a state where the same bug can be silently reintroduced by any future change; the test is the machine-readable specification of the correct behavior that was violated; the alternative — fixing bugs without tests and relying on manual QA to catch regressions — scales at O(n) cost as the codebase grows, while regression tests scale at O(1) per bug

Sources: Google Engineering Practices "Testing" (google.github.io/eng-practices/review); Beck "Test-Driven Development by Example" (Addison-Wesley, 2002) Ch. 1–3; Fowler "Refactoring" (Addison-Wesley, 1999) Ch. 4; Feathers "Working Effectively with Legacy Code" (Prentice Hall, 2004) Ch. 2

### On legacy code without tests

Feathers' "Working Effectively with Legacy Code" (2004) addresses the most common objection — "this code has no tests, I can't write a regression test." Feathers' technique: characterize the current (broken) behavior with a test that documents it, then modify the test to describe the correct behavior, then fix the code. The test infrastructure cost is paid once per module.

## Steps

### 1. Reproduce the bug manually first

Before writing any test, confirm you can reproduce the bug manually:

```
1. Follow the exact steps from the bug report
2. Observe the incorrect behavior
3. Note the precise input conditions that trigger it
4. Note the precise incorrect output or behavior
```

If you cannot reproduce it manually, do not proceed to write a test — return to triage (`triage-bug-report`). A test written without a confirmed reproduction is guesswork.

### 2. Write the smallest failing test

Write an automated test that:
- Reproduces the exact bug (same inputs, same incorrect output demonstrated)
- Fails for the right reason — the bug, not a setup error
- Is at the lowest level possible (unit > integration > E2E — prefer unit)

```python
# Example: Bug — subtraction returns wrong result for negative numbers
# Incorrect behavior: subtract(-3, 2) returns 1 instead of -5

def test_subtract_negative_first_operand():
    # This test should FAIL before the fix
    result = subtract(-3, 2)
    assert result == -5, f"Expected -5, got {result}"
```

```javascript
// Example: Bug — user.fullName() crashes when lastName is null
// Incorrect behavior: TypeError instead of returning just firstName

it('returns firstName when lastName is null', () => {
  const user = new User({ firstName: 'Alice', lastName: null });
  // This test should FAIL before the fix (throws TypeError)
  expect(user.fullName()).toBe('Alice');
});
```

**Test naming convention:** Name the test after the bug behavior being fixed, not the fix:

```
❌ test_fix_subtraction_bug
✅ test_subtract_negative_first_operand_returns_correct_result

❌ test_null_safety
✅ test_full_name_returns_first_name_when_last_name_is_null
```

The name should describe the scenario that was broken, so a future reader knows what this test guards against.

### 3. Run the test suite and confirm the new test fails

```bash
# Run only the new test first
pytest tests/test_math.py::test_subtract_negative_first_operand -v
# OR
npm test -- --testNamePattern="returns firstName when lastName is null"
```

Confirm:
1. **The new test fails** — if it passes without any fix, the test is wrong (wrong assertion, wrong input, or the bug is already fixed)
2. **No other tests fail** — the new test itself should not break existing passing tests; if it does, the test has side effects that need to be cleaned up

**Why confirm failure first:** A test that always passes provides zero value — it cannot detect a regression. The red state (failing test) is the proof that the test is actually testing the bug.

### 4. Implement the minimal fix

Write the smallest change that makes the failing test pass:

```python
# Before (buggy):
def subtract(a, b):
    return abs(a) - b    # bug: uses abs() incorrectly

# After (fixed):
def subtract(a, b):
    return a - b
```

```javascript
// Before (buggy):
fullName() {
  return `${this.firstName} ${this.lastName}`;  // crashes if lastName is null
}

// After (fixed):
fullName() {
  return [this.firstName, this.lastName].filter(Boolean).join(' ');
}
```

**Minimal fix principle:** Fix only what the test specifies. Do not refactor, optimize, or improve adjacent code during a bug fix — that is a separate change that deserves its own test and commit. Mixing a bug fix with a refactor makes the change harder to review and understand.

### 5. Run the full test suite

```bash
npm test
# OR
pytest
# OR
./gradlew test
```

Verify:
1. The new regression test now **passes**
2. All previously-passing tests still **pass**
3. No new test failures introduced by the fix

If the fix caused other tests to fail, those tests are revealing either:
- A wider behavior change than intended (fix is too broad — narrow it)
- Incorrect tests that depended on the buggy behavior (update those tests to reflect correct behavior)

### 6. Commit test and fix together

Commit the regression test and the fix in a single commit:

```bash
git add tests/test_math.py src/math.py
git commit -m "fix(math): correct subtraction for negative first operand

subtract(-3, 2) was returning 1 instead of -5 due to erroneous abs()
call. Adds regression test to prevent recurrence."
```

**Why one commit:** the test and fix are a unit — the test is the specification, the fix is the implementation. Separating them allows the fix to be reverted without the test (losing the guard) or the test to be committed without the fix (failing CI).

**Commit message:** reference the bug/issue number if tracked: `fix(auth): handle null lastName in User#fullName (closes #1234)`.

## Rules

- Write the failing test BEFORE writing the fix — confirms the test actually detects the bug
- Confirm the test fails before fixing — a passing test before any fix is a broken test
- Commit test and fix in the same commit — they are inseparable
- Minimal fix — do not refactor or improve adjacent code in the same commit
- Test at the lowest level possible — prefer unit test over integration test if the bug is in a single function

## Common Mistakes

- **Writing the test after the fix**: the most common deviation — the developer fixes the bug, then writes a test that passes; this does not confirm the test actually detects the bug; always write the test first, run it red, then fix
- **Test passes before the fix**: this means the test is not testing the actual bug — wrong inputs, wrong assertion, or the bug is elsewhere; do not proceed until the test genuinely fails
- **Testing the implementation, not the behavior**: `assert subtract.calls_abs() == False` — tests internal implementation; instead test the observable behavior: `assert subtract(-3, 2) == -5`
- **Mixing fix and refactor in one commit**: the fix might be correct but the refactor introduces a new bug; keep them separate — fix in one commit, refactor (with its own tests) in a follow-up

## When NOT to Use

- When no automated test infrastructure exists and adding it would take longer than the sprint allows — in this case, document the bug scenario in a comment or acceptance test description, plan to add test infrastructure, and track the technical debt; this is the exception, not the rule
- For bugs in UI presentation layer with no testable behavior contract (pixel-perfect visual regressions) — visual regression requires screenshot diffing tools (Percy, Chromatic), not a unit or integration test; use those tools instead

