"""Script utilitaire pour générer des fichiers Python à partir d'un template.

Usage:
    python scripts/generate_py_from_template.py <module_name> [output_path]

Exemple:
    python scripts/generate_py_from_template.py my_module src/my_module.py

Ce script remplace la variable `{{MODULE_NAME}}` dans le template.
"""
from __future__ import annotations

import sys
import pathlib
from typing import Tuple

TEMPLATE_PATH = pathlib.Path(__file__).resolve().parents[1] / "templates" / "python_template.py"


def load_template(path: pathlib.Path) -> str:
    with path.open("r", encoding="utf8") as f:
        return f.read()


def render_template(template: str, module_name: str) -> str:
    return template.replace("{{MODULE_NAME}}", module_name)


def write_output(content: str, out_path: pathlib.Path) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", encoding="utf8") as f:
        f.write(content)


def parse_args(argv: list[str]) -> Tuple[str, pathlib.Path]:
    if len(argv) < 2:
        print("Usage: python scripts/generate_py_from_template.py <module_name> [output_path]")
        sys.exit(2)
    module_name = argv[1]
    if len(argv) >= 3:
        out_path = pathlib.Path(argv[2])
    else:
        out_path = pathlib.Path("src") / f"{module_name}.py"
    return module_name, out_path


def main(argv: list[str] | None = None) -> int:
    argv = argv if argv is not None else sys.argv
    module_name, out_path = parse_args(argv)

    template = load_template(TEMPLATE_PATH)
    content = render_template(template, module_name)
    write_output(content, out_path)
    print(f"Fichier généré: {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
