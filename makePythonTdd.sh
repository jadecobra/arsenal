#!/bin/bash
PROJECT_NAME=$1
mkdir $PROJECT_NAME
cd $PROJECT_NAME
mkdir src
touch src/$PROJECT_NAME.py
mkdir tests
touch tests/__init__.py

echo "import unittest


class Test$PROJECT_NAME(unittest.TestCase):

    def test_failure(self):
        self.assertFalse(True)


# Exceptions Encountered
# AssertionError
" > tests/test_$PROJECT_NAME.py

python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
echo pytest-watch > requirements.txt
python3 -m pip install --requirement requirements.txt
pytest-watch