.PHONY: validate test-schema check-duplicates fix-frontmatter \
        update-plugin-manifest check-manifest bump-version help

validate: ## Validate all SKILL.md files against STANDARD.md
	bash scripts/validate-skill.sh --all

test-schema: ## Run validate-skill.sh conformance test suite
	bash scripts/test-schema.sh

check-duplicates: ## Detect near-duplicate skills added vs origin/main
	bash scripts/check-duplicates.sh

fix-frontmatter: ## Fix unquoted YAML frontmatter values in skill files
	python3 scripts/fix-yaml-frontmatter.py

update-plugin-manifest: ## Auto-generate skills list in .claude-plugin/plugin.json
	python3 scripts/update-plugin-manifest.py

check-manifest: ## Verify plugin.json skill list matches actual dirs
	@actual=$$(find skills -mindepth 1 -type d -name "skills" -not -empty | wc -l | tr -d ' '); \
	listed=$$(python3 -c "import json; d=json.load(open('.claude-plugin/plugin.json')); print(len(d['skills']))"); \
	echo "Actual skill dirs: $$actual"; \
	echo "Listed in manifest: $$listed"; \
	if [ "$$actual" != "$$listed" ]; then \
		echo "MISMATCH — run: make update-plugin-manifest"; exit 1; \
	else \
		echo "OK"; \
	fi

bump-version: ## Bump skills library version — usage: make bump-version V=1.2.3
	@test -n "$(V)" || (echo "Usage: make bump-version V=x.y.z"; exit 1)
	bash scripts/bump-version.sh $(V)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
