.EXPORT_ALL_VARIABLES:
PROJECT=todo
BUCKET=todo
PROFILE=default
DATA_FOLDER=data

## Create virtual environment
venv:
	python3 -m venv venv
	source venv/bin/activate ; pip install --upgrade pip ; python3 -m pip install -r requirements-dev.txt
	source venv/bin/activate ; pip freeze > requirements_freeze.txt

## Clean virtual environment
clean:
	rm -rf venv

## Run the app
run:
	source venv/bin/activate ; PYTHONPATH='./src' python -m app req1 --optional-arg opt1

## App help message
run_help:
	source venv/bin/activate ; PYTHONPATH='./src' python -m app --help

## Run jupyter lab
jupyter:
	source venv/bin/activate; PYTHONPATH='./src' jupyter lab

## Run unit tests
test:
	source venv/bin/activate ; PYTHONPATH='./src' pytest -vvv -s

## Run black code formatter
black:
	source venv/bin/activate ; black  --line-length 120 .

## Run flake8 linter
flake8:
	source venv/bin/activate ; flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
	source venv/bin/activate ; flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

## Upload Data to S3
sync_data_to_s3:
	aws s3 sync $(DATA_FOLDER)/ s3://$(BUCKET)/$(PROJECT)/ --profile $(PROFILE) --exclude ".*"

## Download Data from S3
sync_data_from_s3:
	aws s3 sync s3://$(BUCKET)/$(PROJECT)/ $(DATA_FOLDER)/ --profile $(PROFILE) --exclude ".*"


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
