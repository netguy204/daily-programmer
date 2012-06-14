#!/usr/bin/env bash

if cmp -s $1 $2; then
    echo
else
    cp $2 $1
fi