#!/usr/bin/env bash

###
# Entrypoint script
#
# The script autoload all files in core_lib && extension_lib directory,
# and execute the command passed as an argument.
###

# Bash script autoloader.
function autoload_bash() {
  for f in $1/*; do
    source $f
  done
}

# Bash script directories
DIRECTORY=(
  "/script/core_lib"
  "/script/extension_lib"
)

# Loader
for dir in $DIRECTORY;do
  autoload_bash ${dir}
done

###
# Execute command passed as argument.
###
$1
