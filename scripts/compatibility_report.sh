#!/bin/bash

# check if we are inside a pipenv virtualenv
pipenv --venv
if test $? -eq 0
then
    array=( "0.5" "0.6" "0.6.1" "0.7" )
    for i in "${array[@]}"
    do
        yes | pip uninstall torchvision
        pip install torchvision==$i
        pytest -k allowlist_test --tb=line -n auto
    done

    python tests/syft/lib/allowlist_report.py
else
    echo "Run this inside a pipenv virtualenv"
    exit 1
fi
