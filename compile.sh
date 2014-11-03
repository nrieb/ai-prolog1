#!/usr/bin/env bash

swipl -g bfs_test -t halt -o "$2" -c "$1"
