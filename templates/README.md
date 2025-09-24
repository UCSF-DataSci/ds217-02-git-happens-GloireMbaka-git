Templates Python
===============

Utilisez le template `python_template.py` pour démarrer rapidement un nouveau module.

Génération rapide:

```bash
python scripts/generate_py_from_template.py my_module src/my_module.py
```

Le script remplace `{{MODULE_NAME}}` dans le template et crée le fichier de sortie.

Conseils:
- Remplacez tous les TODO par des instructions et tests.
- Ajoutez des tests pour chaque fonction dans `tests/`.
- Utilisez `black`/`ruff` pour formater et lint.
