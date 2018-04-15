#!/bin/ash

#
#__________________________________________________________________________________________________
# Test build helloworld/helloworld/app.py as android apk
# https://briefcase.readthedocs.io/en/latest/tutorial/tutorial-0.html#start-a-new-project
#
# start e.g.:
#   pybee-docker$ cd tests
#   pybee-docker/tests$ ./run_test.sh test_helloworld.sh
#

set -xe

pip freeze

cd helloworld
ls -la

pip --version
./setup.py --version
./setup.py android -s