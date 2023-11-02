//----------------------------------------------------------------------
//   Copyright 2013 Verilab, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

class dut_env extends uvm_env;

   pipe_env        penv_in;
   pipe_env        penv_out;
   pipe_scoreboard sb;
`ifndef VERILATOR
   pipe_coverage   pipe_cov;
`endif

   `uvm_component_utils(dut_env)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      uvm_config_db#(int)::set(this, "penv_in.agent", "is_active", UVM_ACTIVE);
      uvm_config_db#(int)::set(this, "penv_out.agent", "is_active", UVM_PASSIVE);

      uvm_config_db#(string)::set(this, "penv_in.agent.monitor", "monitor_intf", "in_intf");
      uvm_config_db#(string)::set(this, "penv_out.agent.monitor", "monitor_intf", "out_intf");

      penv_in = pipe_env::type_id::create("penv_in", this);
      penv_out = pipe_env::type_id::create("penv_out", this);

      sb = pipe_scoreboard::type_id::create("sb", this);
`ifndef VERILATOR
      pipe_cov = pipe_coverage::type_id::create("pipe_cov", this);
`endif

      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction: build_phase 

   function void connect_phase(uvm_phase phase);
      penv_in.agent.monitor.item_collected_port.connect(sb.input_packets_collected.analysis_export);
      penv_out.agent.monitor.item_collected_port.connect(sb.output_packets_collected.analysis_export);

`ifndef VERILATOR
      penv_in.agent.monitor.item_collected_port.connect(pipe_cov.analysis_export);
      penv_out.agent.monitor.item_collected_port.connect(pipe_cov.analysis_export);
`endif

      `uvm_info(get_full_name( ), "Connect phase complete.", UVM_LOW)
   endfunction: connect_phase

endclass: dut_env
