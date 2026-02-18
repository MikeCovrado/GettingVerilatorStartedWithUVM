#!/bin/bash
# =============================================================================
# Basic run script for PIPE environment using Verilator
# Original author Mark Litterick, Verilab (www.verilab.com)
# Substantially modified by Mike Thompson, OpenHW (www.openhwgroup.org)
# =============================================================================

# Accelera's UVM library fetched with `wget https://www.accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz` (not yet working)
export UVM_HOME="/opt/accellera/1800.2-2017-1.0/src"

# UVM library previous attemts...
#export UVM_HOME="/home/mike/GitHubRepos/antmicro/verilator-verification-features-tests/main/uvm/uvm-2017/src"
#export UVM_HOME="/home/mike/GitHubRepos/chipsalliance/uvm-verilator/master/src"
#export UVM_HOME="/home/mike/GitHubRepos/antmicro/verilator-verification-features-tests/main/uvm/src"
#export UVM_HOME="/home/mike/GitHubRepos/antmicro/verilator-verification-features-tests/main/uvm/uvm-1.2/src"
#export UVM_HOME="/home/mike/GitHubRepos/antmicro/uvm-verilator/current-patches-deprecated-api/src"

# This is a simple example script to run a simulation
usage() {
  echo ""
  echo "Usage:   $(basename "$0") TESTNAME [-b(ugpoint)] [-h(elp)] "
  echo "Example: $(basename "$0") data0_test"
}

help() {
  usage
  echo ""
  echo "  - run specified TESTNAME"
  echo ""
  echo "Options:"
  echo "  -b(ugpoint)       - Generate sv-bugpoint-input.sv"
  echo "  -h(elp)           - print this message"
  echo ""
}

# prepare by processing command-line options:

# Default values for the various command-line options.
# These variables are all named OPT_XXXXX and are never subsequently altered
OPT_TESTNAME="undefined"
OPT_BUGPOINT=0

# Decode command-line options, allowing wildcard variations, error if invalid
while [ $# -gt 0 ]; do
  opt=${1/#--/-}
  case "$opt" in
    -b*)      OPT_BUGPOINT=1;;
    -h*)      help; exit 0;;
    -*)       usage ; echo "Error: unknown option/argument $1" ; exit 1;;
    *test*)   OPT_TESTNAME=$1;;
  esac
  shift
done

if [ "$OPT_TESTNAME" = "undefined" ]; then
  usage >&2
  echo "Error: test file must be specified"
  exit 1
fi

# process command-line options

if [ $OPT_BUGPOINT == 1 ]; then
  #ARG_BUGPOINT="../tb/top.sv > sv-bugpoint-input.sv"
  ARG_BUGPOINT="> sv-bugpoint-input.sv"
  ARG_VERILATOR="-E -P --cc"
else
  #ARG_BUGPOINT="../tb/top.sv"
  ARG_BUGPOINT=""
  ARG_VERILATOR="--binary --build --cc"
fi

# Location of UVM class library.  It is best to use the one from ChipsAlliance.
if [[ -z "${UVM_HOME}" ]]; then
  echo "Please set shell environment variable UVM_HOME to point at your UVM class library"
  exit 1
else
  echo "Using $UVM_HOME to point at your UVM class library"
fi
UVM_PKG="$UVM_HOME/uvm_pkg.sv"

# Deliberately disabled warnings (all from the UVM class library)
# Note that shellcheck does not like this coding style... too bad.
DISABLED_WARNINGS="-Wno-DECLFILENAME \
                   -Wno-CONSTRAINTIGN \
                   -Wno-MISINDENT \
                   -Wno-VARHIDDEN \
                   -Wno-WIDTHTRUNC \
                   -Wno-CASTCONST \
                   -Wno-WIDTHEXPAND \
                   -Wno-UNDRIVEN \
                   -Wno-UNUSEDSIGNAL \
                   -Wno-UNUSEDPARAM \
                   -Wno-SYMRSVDWORD \
                   -Wno-ZERODLY \
                   -Wno-CASEINCOMPLETE \
                   -Wno-SIDEEFFECT \
                   -Wno-fatal \
                   -Wno-REALCVT"

OBJ_DIR="verilator_obj_dir"

rm -rf $OBJ_DIR

# Redundant Verilator arguments
#     +define+VERILATOR \
#     -sv \
#    $ARG_VERILATOR \
#   --build \
#   --cc \
# Unusable Verilator arguments
#     +define+UVM_ENABLE_DEPRECATED_API \
# Misc args
#   --prof-cfuncs -CFLAGS -DVL_DEBUG \
#   --coverage \
verilator \
    --binary \
    --Mdir $OBJ_DIR \
    --error-limit 5 \
    --hierarchical \
    -j 4 \
    -Wall \
    --timescale 1ns/1ns \
    $DISABLED_WARNINGS \
    +define+UVM_REPORT_DISABLE_FILE_LINE \
    +define+UVM_NO_DPI \
    +define+SVA_ON \
    +incdir+"$UVM_HOME" \
    +incdir+../rtl \
    +incdir+../sv \
    +incdir+../tb \
    "$UVM_PKG" \
    ../sv/pipe_pkg.sv \
    ../sv/pipe_if.sv \
    ../rtl/pipe.v \
    ../tb/top.sv \
    $ARG_BUGPOINT

#   ../tb/top.sv > sv-bugpoint-input.sv
#   ../tb/top.sv -E -P > sv-bugpoint-input.sv

# run
./verilator_obj_dir/Vuvm_pkg +UVM_TESTNAME="$OPT_TESTNAME" \
                             +UVM_OBJECTION_TRACE \
                             +uvm_set_severity=*,UVM\/COMP\/NAME, UVM_WARNING, UVM_INFO
#                            +uvm_set_severity=<comp>,<id>,<current_severity>,<new_severity>

echo ""
echo "Ran with:"
echo -n "  "
verilator -version
echo "  UVM_HOME=$UVM_HOME"
