#!/bin/bash

export PORT=5100

cd ~/www/tasktrackerapp
./bin/tasktrackerapp stop || true
./bin/tasktrackerapp start

