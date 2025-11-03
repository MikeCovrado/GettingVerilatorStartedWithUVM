# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
Sources fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## You can help!
Check out the Issues and filter on 'Good First Issue.'

## Current status
0. **Success!**  Well, _partial_ success:
  - Currently compiles and executes with Verilator v5.040 on Ubuntu 24.04.
  - Does _not_ compile with Verilator v5.042 (_might_ be related to [Verilator #4767](https://github.com/verilator/verilator/issues/4767)).
  - Uses a custom version of the UVM Library (see `scripts/run_verilator.sh`).
1. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
```
`ifdef VERILATOR
  // code that is not supported by Verilator...
`else
  // temporary work-around
`endif
```
2. Compiles with zero errors (subject to a rather long list of disabled warnings).
3. Successful execution of the `data0_test`:
```
- V e r i l a t i o n   R e p o r t: Verilator 5.040 2025-08-30 rev v5.040
- Verilator: Built from 19.293 MB sources in 355 modules, into 33.040 MB in 5345 C++ files needing 15.651 MB
- Verilator: Walltime 313.611 s (elab=0.792, cvt=6.087, bld=304.596); cpu 7.913 s on 1 threads; alloced 248.867 MB
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
UVM_INFO @ 0: reporter [uvm_test_top.env.penv_in.agent.driver] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] INTERFACE USED = in_intf
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [uvm_test_top.env.penv_in.agent.monitor] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out [uvm_test_top.env.penv_out] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent [uvm_test_top.env.penv_out.agent] Build stage complete.
UVM_INFO @ 0: reporter [uvm_test_top.env.penv_out.agent.driver] Build stage complete.
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
uvm_test_top                    data0_test                  -     @123 
  env                           dut_env                     -     @170 
    penv_in                     pipe_env                    -     @193 
      agent                     pipe_agent                  -     @229 
        driver                  pipe_driver                 -     @412 
          rsp_port              uvm_analysis_port           -     @435 
          seq_item_port         uvm_seq_item_pull_port      -     @423 
        monitor                 pipe_monitor                -     @447 
          item_collected_port   uvm_analysis_port           -     @479 
        sequencer               pipe_sequencer              -     @247 
          rsp_export            uvm_analysis_export         -     @258 
          seq_item_export       uvm_seq_item_pull_imp       -     @400 
          arbitration_queue     array                       0     -    
          lock_queue            array                       0     -    
          num_last_reqs         integral                    32    'd1  
          num_last_rsps         integral                    32    'd1  
    penv_out                    pipe_env                    -     @204 
      agent                     pipe_agent                  -     @508 
        driver                  pipe_driver                 -     @690 
          rsp_port              uvm_analysis_port           -     @713 
          seq_item_port         uvm_seq_item_pull_port      -     @701 
        monitor                 pipe_monitor                -     @725 
          item_collected_port   uvm_analysis_port           -     @757 
        sequencer               pipe_sequencer              -     @525 
          rsp_export            uvm_analysis_export         -     @536 
          seq_item_export       uvm_seq_item_pull_imp       -     @678 
          arbitration_queue     array                       0     -    
          lock_queue            array                       0     -    
          num_last_reqs         integral                    32    'd1  
          num_last_rsps         integral                    32    'd1  
    sb                          pipe_scoreboard             -     @215 
      input_packets_collected   uvm_tlm_analysis_fifo #(T)  -     @786 
        analysis_export         uvm_analysis_imp            -     @845 
        get_ap                  uvm_analysis_port           -     @833 
        get_peek_export         uvm_get_peek_imp            -     @809 
        put_ap                  uvm_analysis_port           -     @821 
        put_export              uvm_put_imp                 -     @797 
      output_packets_collected  uvm_tlm_analysis_fifo #(T)  -     @857 
        analysis_export         uvm_analysis_imp            -     @916 
        get_ap                  uvm_analysis_port           -     @904 
        get_peek_export         uvm_get_peek_imp            -     @880 
        put_ap                  uvm_analysis_port           -     @892 
        put_export              uvm_put_imp                 -     @868 
-----------------------------------------------------------------------

UVM_INFO @ 0: reporter [UVM/COMP/NAMECHECK] This implementation of the component name checks requires DPI to be enabled
UVM_WARNING @ 0: reporter [UVM/COMP/NAME] the name "uvm_test_top" of the component "uvm_test_top" violates the uvm component name constraints

...snipping a large number of UVM_WARNING messages simular to the above...

UVM_INFO @ 0: reporter [pipe_driver] Resetting signals ... 
UVM_INFO @ 0: reporter [pipe_driver] Resetting signals ... 
UVM_INFO @ 1575: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 77
UVM_INFO @ 1575: uvm_test_top.env.penv_out.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 77
UVM_INFO @ 1575: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   24
UVM_WARNING :   57
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[NO_DPI_TSTNAME]     1
[RNTST]     1
[UVM/COMP/NAME]    57
[UVM/COMP/NAMECHECK]     1
[UVM/RELNOTES]     1
[data0_test]     1
[pipe_driver]     2
[pipe_monitor]     4
[uvm_test_top.env]     2
[uvm_test_top.env.penv_in]     1
[uvm_test_top.env.penv_in.agent]     2
[uvm_test_top.env.penv_in.agent.driver]     1
[uvm_test_top.env.penv_in.agent.monitor]     1
[uvm_test_top.env.penv_out]     1
[uvm_test_top.env.penv_out.agent]     2
[uvm_test_top.env.penv_out.agent.driver]     1
[uvm_test_top.env.penv_out.agent.monitor]     1
[uvm_test_top.env.sb]     1

- /home/mike/GitHubRepos/antmicro/uvm-verilator/current-patches-deprecated-api/src/base/uvm_root.svh:585: Verilog $finish
- S i m u l a t i o n   R e p o r t: Verilator 5.040 2025-08-30
- Verilator: $finish at 2ns; walltime 3.939 s; speed 10.128 ns/s
- Verilator: cpu 0.156 s on 1 threads; alloced 84 MB
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

## Future Work
1. Clean up all those `UVM_WARNING @ 0: reporter [UVM/COMP/NAME]` warnings.
2. Ensure both `data0_test` and `data1_test` are doing what they _should_ be doing.
3. Remove any existing `ifdef VERILATOR` work-arounds.
4. Start pushing advanced randomization of stimulus.
