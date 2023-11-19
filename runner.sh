#!/bin/sh
# arguments passed to this shell script
# 1 - 'NODE' usually $PIPELINE_HOME/<node>
# 2 - 'OUT' the destination for the data on success, another $PIPELINE_HOME/<node>
# 3 - 'EXE' command to run on data. must process the file and not change location.
# On sucessful processing, the file will be passed to the OUT directory, specified in the system.path file
#
# pipeline directories
# pipeline/<node>/
#   - debug -> where to place files if there is an error
#   - proc -> files are moved here while being processed to prevent duplicate processing
#
# Script initiated when node receives file change inotify from systemd (unit.path and unit.service files)
# This scripts moves all files to ./proc subdir and runs the exe on each
# If EXE passed runs successfully, file is passed to the next node
# If EXE fails, data objects is passed to debug.


NODE=$1
OUT=$2
EXE=$3

# Function should allow background processes to spawn, and make sure long running exe does not
# bottleneck and create confusion on next file run.
process_file()
{
  NODE=$1
  OUT=$2
  EXE=$3
  BASE_FILENAME=$4

  mv $NODE/$BASE_FILENAME $NODE/proc/
  $EXE $NODE/proc/$BASE_FILENAME
  # if return code is succes, will do next action, otherwise data moved to debug.
  if [ $? -eq 0 ]
  then
    mv $NODE/proc/$BASE_FILENAME $OUT/$BASE_FILENAME
  else
    mv $NODE/proc/$BASE_FILENAME $NODE/debug/$BASE_FILENAME
  fi
}


for fn in $(find $NODE -type f); do
  BASE_FILENAME=$(basename $fn)

  process_file $NODE $OUT $EXE $BASE_FILENAME
done

