<!--
Copyright (c) 2026 Eclipse Foundation
SPDX-License-Identifier: Apache-2.0
-->
# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
The sources were fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## You can help!
Check out the Issues and filter on 'Good First Issue',
or try something from 'Future Work' (at the end of this README).

## Current status
1. **Success!**
  - Compiles and executes with Verilator **v5.048** on Ubuntu 24.04.
  - UVM library version is 1800.2-2017-1.0 (see UVM_HOME in `sim/Makefile`).
2. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
```
`ifdef VERILATOR
  // code that is not supported by Verilator...
`else
  // temporary work-around
`endif
```
3. Compiles with zero errors (subject to a rather long list of disabled warnings).
4. Large number of UVM_WARNING @ t=0: (violations the uvm component name constraints). Investigating.
5. Successful execution of the `data0_test`:
<details>

```
- V e r i l a t i o n   R e p o r t: Verilator 5.048 2026-04-26 rev v5.048
- Verilator: Built from 14.784 MB sources in 357 modules, into 27.912 MB in 2057 C++ files needing 99.124 MB
- Verilator: Walltime 159.445 s (elab=0.655, cvt=2.419, bld=154.623); cpu 4.457 s on 4 threads; allocated 288.848 MB

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
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent [uvm_test_top.env.penv_in.agent] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.driver [uvm_test_top.env.penv_in.agent.driver] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] INTERFACE USED = in_intf
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [uvm_test_top.env.penv_in.agent.monitor] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out [uvm_test_top.env.penv_out] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent [uvm_test_top.env.penv_out.agent] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent.monitor [pipe_monitor] INTERFACE USED = out_intf
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent.monitor [uvm_test_top.env.penv_out.agent.monitor] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.sb [uvm_test_top.env.sb] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent [uvm_test_top.env.penv_in.agent] Connect stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent [uvm_test_top.env.penv_out.agent] Connect stage complete.
UVM_INFO @ 0: uvm_test_top.env [uvm_test_top.env] Connect phase complete.
UVM_INFO @ 0: uvm_test_top [data0_test] Printing the test topology :
-----------------------------------------------------------------------
Name                            Type                        Size  Value
-----------------------------------------------------------------------
uvm_test_top                    data0_test                  -     @121 
  env                           dut_env                     -     @166 
    penv_in                     pipe_env                    -     @187 
      agent                     pipe_agent                  -     @236 
        driver                  pipe_driver                 -     @389 
          rsp_port              uvm_analysis_port           -     @408 
          seq_item_port         uvm_seq_item_pull_port      -     @398 
        monitor                 pipe_monitor                -     @418 
          item_collected_port   uvm_analysis_port           -     @444 
        sequencer               pipe_sequencer              -     @252 
          rsp_export            uvm_analysis_export         -     @261 
          seq_item_export       uvm_seq_item_pull_imp       -     @379 
          arbitration_queue     array                       0     -    
          lock_queue            array                       0     -    
          num_last_reqs         integral                    32    'd1  
          num_last_rsps         integral                    32    'd1  
    penv_out                    pipe_env                    -     @196 
      agent                     pipe_agent                  -     @463 
        monitor                 pipe_monitor                -     @478 
          item_collected_port   uvm_analysis_port           -     @498 
    pipe_cov                    pipe_coverage               -     @214 
      analysis_imp              uvm_analysis_imp            -     @223 
    sb                          pipe_scoreboard             -     @205 
      input_packets_collected   uvm_tlm_analysis_fifo #(T)  -     @516 
        analysis_export         uvm_analysis_imp            -     @565 
        get_ap                  uvm_analysis_port           -     @555 
        get_peek_export         uvm_get_peek_imp            -     @535 
        put_ap                  uvm_analysis_port           -     @545 
        put_export              uvm_put_imp                 -     @525 
      output_packets_collected  uvm_tlm_analysis_fifo #(T)  -     @575 
        analysis_export         uvm_analysis_imp            -     @624 
        get_ap                  uvm_analysis_port           -     @614 
        get_peek_export         uvm_get_peek_imp            -     @594 
        put_ap                  uvm_analysis_port           -     @604 
        put_export              uvm_put_imp                 -     @584 
-----------------------------------------------------------------------

UVM_INFO @ 0: reporter [UVM/COMP/NAMECHECK] This implementation of the component name checks requires DPI to be enabled
UVM_WARNING @ 0: reporter [UVM/COMP/NAME] the name "uvm_test_top" of the component "uvm_test_top" violates the uvm component name constraints
... deleted a rather large number of warnings similar to the above ...

UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.driver [pipe_driver] Resetting signals ... 
UVM_INFO @ 1545: uvm_test_top.env.pipe_cov [pipe_coverage] Number of coverage packets collected = 152
UVM_INFO @ 1545: uvm_test_top.env.pipe_cov [pipe_coverage] Current coverage  = 0.000000
UVM_INFO @ 1545: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 76
UVM_INFO @ 1545: uvm_test_top.env.penv_out.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 76
UVM_INFO @ 1545: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   24
UVM_WARNING :   42
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[NO_DPI_TSTNAME]     1
[RNTST]     1
[UVM/COMP/NAME]    42
[UVM/COMP/NAMECHECK]     1
[UVM/RELNOTES]     1
[data0_test]     1
[pipe_coverage]     2
[pipe_driver]     1
[pipe_monitor]     4
[uvm_test_top.env]     2
[uvm_test_top.env.penv_in]     1
[uvm_test_top.env.penv_in.agent]     2
[uvm_test_top.env.penv_in.agent.driver]     1
[uvm_test_top.env.penv_in.agent.monitor]     1
[uvm_test_top.env.penv_out]     1
[uvm_test_top.env.penv_out.agent]     2
[uvm_test_top.env.penv_out.agent.monitor]     1
[uvm_test_top.env.sb]     1

- /opt/accellera/1800.2-2017-1.0/src/base/uvm_root.svh:585: Verilog $finish
- S i m u l a t i o n   R e p o r t: Verilator 5.048 2026-04-26
- Verilator: $finish at 2us; walltime 0.373 s; speed 11.276 us/s
- Verilator: cpu 0.137 s on 1 threads; allocated 45 MB
```
</details>

## Try it yourself!
1. Install the latest version of Verilator (v5.046 or better).  See https://verilator.org/guide/latest/install.html for details.
2. Run it!
```
$ cd sim
$ make all
```

## Future Work
1. Clean up all those `UVM_WARNING @ 0: reporter [UVM/COMP/NAME]` warnings.
2. Ensure both `data0_test` and `data1_test` are doing what they _should_ be doing.
3. Investigate the run-time warnings.
4. Starting removing the DISABLED WARNINGS in the Makefile.
4. Remove any existing `ifdef VERILATOR` work-arounds.
5. Start pushing advanced randomization of stimulus.
