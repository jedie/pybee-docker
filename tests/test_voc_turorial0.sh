#!/bin/ash

#
#__________________________________________________________________________________________________
# Test VOC by build a "Hello World"
# https://voc.readthedocs.io/en/latest/tutorial/tutorial-0.html
#
# start e.g.:
#   pybee-docker$ cd tests
#   pybee-docker/tests$ ./run_test.sh test_voc_turorial0.sh
#

set -xe

mkdir -p /tmp/voc_tutorial0
cd /tmp/voc_tutorial0

echo "print('\n')">example.py
echo "print('*'*79)">>example.py
echo "print('Hello World!')">>example.py
echo "print('*'*79)">>example.py
echo "print('\n')">>example.py

voc -v example.py
java -classpath ${PYTHON_JAVA_SUPPORT_JAR}:. python.example

rm -Rfv /tmp/voc_tutorial0