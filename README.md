# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
Sources fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## Current status
0. Last tested with Verilator v5.040 on Ubuntu 24.04.
1. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
```
`ifdef VERILATOR
  // code that is not supported by Verilator...
`else
  // temporary work-around
`endif
```
2. Compiles with zero errors (subject to a rather long list of disabled warnings).
3. Execution aborts at t=0 during the build phase:
```
- V e r i l a t i o n   R e p o r t: Verilator 5.040 2025-08-30 rev v5.040
- Verilator: Built from 19.373 MB sources in 355 modules, into 33.127 MB in 5346 C++ files needing 15.654 MB
- Verilator: Walltime 368.910 s (elab=0.727, cvt=5.844, bld=361.106); cpu 7.804 s on 1 threads; alloced 249.438 MB
UVM_INFO @ 0: reporter [UVM/RELNOTES] 
  ***********       IMPORTANT RELEASE NOTES         ************

  This implementation of the UVM Library deviates from the 1800.2-2017
  standard.  See the DEVIATIONS.md file contained in the release
  for more details.

----------------------------------------------------------------
Accellera:1800.2-2017:UVM:1.0

All copyright owners for this kit are listed in NOTICE.txt
All Rights Reserved Worldwide
----------------------------------------------------------------

      (Specify +UVM_NO_RELNOTES to turn off this notice)

UVM_INFO @ 0: reporter [NO_DPI_TSTNAME] UVM_NO_DPI defined--getting UVM_TESTNAME directly, without DPI
UVM_INFO @ 0: reporter [RNTST] Running test data0_test...
UVM_INFO @ 0: uvm_test_top.env [uvm_test_top.env] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in [uvm_test_top.env.penv_in] Build stage complete.
[0] %Error: pipe_agent.sv:27: Assertion failed in pipe_pkg.pipe_agent.__m_uvm_execute_field_op: 'assert' failed.
%Error: ../sv/pipe_agent.sv:27: Verilog $stop
Aborting...
```

## Try it yourself!
1. Install the latest version of Verilator.  See https://verilator.org/guide/latest/install.html for details.
2. Create a shell environment variable `ANTMICRO` to point to where you would like you clone of the UVM library to be:
```
$ git clone -b current-patches-deprecated-api https://github.com/antmicro/uvm-verilator.git $ANTMICRO/current-patches-deprecated-api
```

3. Edit the (somewhat brain-dead) run-script to point a shell environment variable `UVM_HOME` to point to the above:
```
$ vim scripts/run_verilator.sh
>>> export UVM_HOME="$ANTMICRO/current-patches-deprecated-api/src"
```

4. Run it!
```
$ cd scripts
$ ./run_verilator.sh data0_test
```
