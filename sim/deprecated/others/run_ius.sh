#!/bin/sh
# =============================================================================
# @brief  basic run script for I2C tests using Cadence IUS
# @author Mark Litterick, Verilab (www.verilab.com)
# =============================================================================

# This is a simple example script to run a simulation
  usage() {
    echo ""
    echo "Usage: $(basename $0) TESTNAME [-g(ui)] [-c(overage)] [-s(eed) SVSEED] [-v(erbose)] [-h(elp)] "
  }

  help() {
    usage
    echo ""
    echo "  - run specified test"
    echo ""
    echo "Options:"
    echo "  -g(ui)            - GUI"
    echo "  -c(over)          - COVERAGE"
    echo "  -s(eed) SVSEED    - non-random SVSEED"
    echo "  -v(erbose)        - UVM_HIGH"
    echo "  -h(elp)           - print this message"
    echo ""
  }

# prepare by processing command-line options:

  # Default values for the various command-line options.
  # These variables are all named OPT_XXXXX and are never subsequently altered

    OPT_TESTNAME="undefined"
    OPT_GUI=0
    OPT_COV=0
    OPT_SEED=0
    OPT_VERBOSE=0
    OPT_SVSEED=1
    OPT_CFG_DEBUG="+UVM_CONFIG_DB_TRACE"
    OPT_SIM=""

  # Decode command-line options, allowing wildcard variations, error if invalid
    while [ $# -gt 0 ]; do
      opt=${1/#--/-}
      case "$opt" in
        -g*)      OPT_GUI=1;;
        -c*)      OPT_COV=1;;
        -s*)      OPT_SEED=1; OPT_SVSEED=$2; shift;;
        -v*)      OPT_VERBOSE=1;;
        -h*)      help; exit 0;;
        -*)       usage ; echo "Error: unknown option/argument $1" ; exit 1;;
        *test*)   OPT_TESTNAME=$1;;
      esac
      shift
    done

    if [ "OPT_TESTNAME" = "undefined" ]; then
      usage >&2
      echo "Error: test file must be specified"
      exit 1
    fi

# process command-line options

  if [ $OPT_GUI == 1 ]; then
    OPT_SIM=" -gui -ida +UVM_HYPERLINKS=ON -linedebug -input ../scripts/ius_sim_gui.tcl -input ../scripts/ius_ida_probe.tcl "
  else
    OPT_SIM=" -linedebug -input ../scripts/ius_sim_nogui.tcl "
  fi
  
  if [ $OPT_COV == 1 ]; then
    OPT_SIM="$OPT_SIM -coverage all -covoverwrite -covtest $OPT_TESTNAME "
#    OPT_SIM="$OPT_SIM -coverage functional -covoverwrite -covtest $OPT_TESTNAME "
  fi
  
  if [ $OPT_SEED == 1 ]; then
    OPT_SIM="$OPT_SIM -svseed $OPT_SVSEED "
  else
    OPT_SIM="$OPT_SIM -svseed random "
  fi
  
  if [ $OPT_VERBOSE == 1 ]; then
    OPT_SIM="$OPT_SIM +UVM_VERBOSITY=UVM_HIGH "
  fi
  
# compile, elaborate and simulate

irun \
 -incdir ../rtl \
 -incdir ../sv \
 -incdir ../tb \
 ../sv/pipe_pkg.sv  \
 ../sv/pipe_if.sv  \
 ../rtl/pipe.v \
 ../tb/top.sv \
 -nowarn BADPRF \
 -nowarn MRSTAR \
 -nowarn NOTLRM \
 -nowarn CUVIHR \
 -define UVM_REPORT_DISABLE_FILE_LINE \
 -define SVA_ON \
 -vtimescale "1 ps / 1 ps"  \
 -licqueue \
 $OPT_DEBUG \
 $OPT_SIM \
 $OPT_CFG_DEBUG \
 +UVM_TESTNAME=$OPT_TESTNAME
 
if ! ../scripts/analyze.pl -quiet irun.log; then
  echo "[$OPT_TESTNAME]:    FAIL" 
else
  echo "[$OPT_TESTNAME]:    PASS" 
fi
echo " " 
