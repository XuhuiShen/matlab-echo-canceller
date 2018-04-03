#! /bin/env bash

../../../tools/wave_extract -i ../../../data-hub/elevator/mics-16-d.wav -s 1 -m 4 -o aecNear.wav
../../../tools/wave_extract -i ../../../data-hub/elevator/mics-16-d.wav -s 1 -m 5 -o aecFar.wav
