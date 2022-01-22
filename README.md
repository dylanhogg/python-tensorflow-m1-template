# Python TensorFlow on Apple M1 project template

[![Latest Tag](https://img.shields.io/github/v/tag/dylanhogg/python-tensorflow-m1-template)](https://github.com/dylanhogg/python-tensorflow-m1-template/tags)
[![Build](https://github.com/dylanhogg/python-tensorflow-m1-template/workflows/build/badge.svg)](https://github.com/dylanhogg/python-tensorflow-m1-template/actions)

A quick-start TensorFlow on Apple M1 GPU project template featuring:

1) Creates Conda environment with TensorFlow optimised for Apple M1 GPU (encapsulated in `create-conda-tensorflow-env.sh`)
2) Useful functionality wrapped in a `Makefile`
3) Helpful default packages (details below)
4) Nicely configured JupyterLab for experiments with example notebook loading external scripts
6) A Python `.gitignore`
7) A GitHub build action
8) Example app showing logging and CLI arg parsing

Based on the more generic Python template: https://github.com/dylanhogg/python-project-template


## Makefile support for common tasks

1) `make create-conda-env` - create an isolated Conda environment and install TensorFlow on M1 packages:
   1) tensorflow-deps
   2) tensorflow-macos
   3) tensorflow-metal
   4) tensorflow-datasets
2) `make run` - run the main app in venv with appropriate paths set
3) `make jupyter` - launch [jubyter lab](https://jupyterlab.readthedocs.io/) with `/notebooks` root folder but still retaining notebook access to the parent `/src` and `/log` folders 
4) `make test` - run unit tests
5) `make black` - format code and `make flake8` for linting  
6) `make sync_data_to_s3` and `make sync_data_from_s3` - sync data with an s3 bucket

Type `make` for all commands.


## Application libraries included in template

1) [Python-dotenv](https://github.com/theskumar/python-dotenv) for environment variable management   
2) [Sphinx](https://github.com/sphinx-doc/sphinx) to create documentation  
3) [Typer](https://github.com/tiangolo/typer) for building CLI applications  
4) [tqdm](https://github.com/tqdm/tqdm) for smart progress bar support  
5) [Loguru](https://github.com/Delgan/loguru) for pleasant and powerful logging  


## Development libraries included in template

1) [pytest](https://github.com/pytest-dev/pytest) for writing your tests   
2) [Black](https://github.com/psf/black) for code formatting  
3) [Flake8](https://github.com/pycqa/flake8) for code style linting  
4) [JupyterLab](https://github.com/jupyterlab/jupyterlab) for notebooks  


## Other Python templates for inspiration/alternatives

1) https://github.com/TezRomacH/python-package-template
2) https://github.com/drivendata/cookiecutter-data-science
3) https://github.com/crmne/cookiecutter-modern-datascience


## Improvements

1) More GitHub actions
2) Replace requirements with [Poetry](https://python-poetry.org/)
3) Investigate adding static Typing checking, e.g. [mypy](https://github.com/python/mypy)
4) Turn into a [cookiecutter](https://cookiecutter.readthedocs.io/) template
5) Add more examples in `/src/examples`
