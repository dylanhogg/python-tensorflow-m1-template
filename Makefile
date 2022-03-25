.EXPORT_ALL_VARIABLES:
PROJECT=todo
BUCKET=todo
PROFILE=default
DATA_FOLDER=data
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh

## Create conda TensorFlow environment
create-conda-env:
	./create-conda-tensorflow-env.sh
	$(CONDA_ACTIVATE); conda activate ./env; conda list --export > requirements_conda_export.txt

## Clean conda environment
clean-conda-env:
	rm -rf env

## Info on conda activate
conda-activate:
	@echo "I don't run well from a Makefile, just do: 'conda activate ./env' then 'conda deactivate' later"

## Conda list
conda-list:
	$(CONDA_ACTIVATE); conda activate ./env; conda list

## Python env info
python-info:
	$(CONDA_ACTIVATE); conda activate ./env; python --version; which -a python

## Run jupyter lab
jupyter:
	$(CONDA_ACTIVATE); conda activate ./env; PYTHONPATH='./src' jupyter lab

## Run the app
run:
	$(CONDA_ACTIVATE); conda activate ./env; PYTHONPATH='./src' python -m app req1 --optional-arg opt1

## App help message
run_help:
	$(CONDA_ACTIVATE); conda activate ./env; PYTHONPATH='./src' python -m app --help

## Run unit tests
test:
	$(CONDA_ACTIVATE); conda activate ./env; PYTHONPATH='./src' pytest -vvv -s --ignore=env

## Run black code formatter
black:
	$(CONDA_ACTIVATE); conda activate ./env; black  --line-length 120 .

## Run flake8 linter
flake8:
	$(CONDA_ACTIVATE); conda activate ./env; flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
	$(CONDA_ACTIVATE); conda activate ./env; flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

## Upload Data to S3
sync_data_to_s3:
	aws s3 sync $(DATA_FOLDER)/ s3://$(BUCKET)/$(PROJECT)/ --profile $(PROFILE) --exclude ".*"

## Download Data from S3
sync_data_from_s3:
	aws s3 sync s3://$(BUCKET)/$(PROJECT)/ $(DATA_FOLDER)/ --profile $(PROFILE) --exclude ".*"

## Create asitop venv
venv_asitop:
	python3 -m venv venv_asitop
	source venv_asitop/bin/activate ; pip install --upgrade pip ; python3 -m pip install asitop
	source venv_asitop/bin/activate ; pip freeze > requirements_freeze.txt

## Run asitop (Performance monitoring CLI tool for Apple Silicon)
asitop:
	source venv_asitop/bin/activate ; sudo asitop



#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
