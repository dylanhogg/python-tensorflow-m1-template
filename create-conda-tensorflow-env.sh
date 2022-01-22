#!/bin/bash
set -e

# Create a conda environment with Tensorflow for Apple M1 GPUs
# Assumes you have conda or conda miniforge installed
# If on OSX you can `brew install miniforge` otherwise see instructions at: https://github.com/conda-forge/miniforge

# Refs:
# https://github.com/conda-forge/miniforge/
# https://developer.apple.com/metal/tensorflow-plugin/
# https://github.com/mrdbourke/m1-machine-learning-test

echo "***** CREATE: conda evironment"
conda create -y --prefix ./env
eval "$(conda shell.bash hook)"
conda activate ./env

echo "***** INSTALLING: tensorflow-deps (incl python and pip)..."
# tensorflow-deps versions are following base TensorFlow versions, see: https://www.tensorflow.org/versions
conda install -y -c apple tensorflow-deps==2.7.0

echo "***** INSTALLING: tensorflow-macos..."
python -m pip install tensorflow-macos

echo "***** INSTALLING: tensorflow-metal..."
python -m pip install tensorflow-metal

echo "***** INSTALLING: tensorflow-datasets..."
python -m pip install tensorflow-datasets

conda list --export > conda_export_tensorflow_only.txt

echo "***** INSTALLING: requirements..."
conda install -y --file requirements.txt
conda list --export > conda_export_requirements_included.txt

echo "***** FINISHED: showing env info..."
python --version
conda list | grep tensorflow

echo "activate env with: 'conda activate ./env'"
echo "run jupyter with: jupyter lab'"
