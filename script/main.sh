#!/usr/bin/env bash

function autoload_bash() {
  for f in $1/*; do
    source $f
  done
}

DIRECTORY=(
  "/script/core_lib"
  "/script/extension_lib"
)

for dir in $DIRECTORY;do
  autoload_bash ${dir}
done
