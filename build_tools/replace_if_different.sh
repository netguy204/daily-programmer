#!/usr/bin/env bash

if cmp -s $1 $2; then
    : # noop
else
    cp $2 $1
fi