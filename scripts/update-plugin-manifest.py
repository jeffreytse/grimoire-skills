#!/usr/bin/env python3
"""Auto-generate the skills list in .claude-plugin/plugin.json and marketplace.json
from the actual skills directory structure. Run before each release."""

import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent


def find_skill_paths():
    result = subprocess.run(
        ["find", "skills", "-mindepth", "1", "-type", "d", "-name", "skills",
         "-not", "-empty"],
        capture_output=True, text=True, cwd=ROOT
    )
    if result.returncode != 0:
        print(f"error: find failed: {result.stderr}", file=sys.stderr)
        sys.exit(1)
    paths = sorted(
        "./" + p.strip()
        for p in result.stdout.strip().splitlines()
        if p.strip()
    )
    return paths


def update_json(path, updater):
    with open(path) as f:
        data = json.load(f)
    updater(data)
    with open(path, "w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")


def main():
    paths = find_skill_paths()

    plugin_json = ROOT / ".claude-plugin" / "plugin.json"
    marketplace_json = ROOT / ".claude-plugin" / "marketplace.json"

    update_json(plugin_json, lambda d: d.update({"skills": paths}))
    update_json(marketplace_json, lambda d: d["plugins"][0].update({"skills": paths}))

    print(f"Updated: {len(paths)} skill paths")
    print(f"  {plugin_json.relative_to(ROOT)}")
    print(f"  {marketplace_json.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
