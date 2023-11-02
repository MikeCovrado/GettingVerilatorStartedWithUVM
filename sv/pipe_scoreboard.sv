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

class pipe_scoreboard extends uvm_scoreboard;
   uvm_tlm_analysis_fifo #(data_packet) input_packets_collected;
   uvm_tlm_analysis_fifo #(data_packet) output_packets_collected;

   data_packet input_packet;
   data_packet output_packet;

   `uvm_component_utils(pipe_scoreboard)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      input_packets_collected = new("input_packets_collected", this);
      output_packets_collected = new("output_packets_collected", this);
      input_packet = data_packet::type_id::create("input_packet");
      output_packet = data_packet::type_id::create("output_packet");
      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
       watcher( );
   endtask: run_phase

   virtual task watcher( );
      forever begin
         input_packets_collected.get(input_packet);
         output_packets_collected.get(output_packet);
         compare_data( );
      end
   endtask: watcher

   virtual task compare_data( );
      bit [15:0] exp_data0;
      bit [15:0] exp_data1;

      if((input_packet.data_in0 == 16'h0000) || (input_packet.data_in0 == 16'hffff))
         exp_data0 = input_packet.data_in0;
      else 
         exp_data0 = input_packet.data_in0 * input_packet.cf;

      if((input_packet.data_in1 == 16'h0000) || (input_packet.data_in1 == 16'hffff))
         exp_data1 = input_packet.data_in1;
      else 
         exp_data1 = input_packet.data_in1 * input_packet.cf;

      if(exp_data0 != output_packet.data_out0)
         `uvm_error(get_type_name( ), $sformatf("Actual output data %0h does not match expected %0h", output_packet.data_out0, exp_data0))

      if(exp_data1 != output_packet.data_out1)
         `uvm_error(get_type_name( ), $sformatf("Actual output data %0h does not match expected %0h", output_packet.data_out1, exp_data1))

   endtask:compare_data

endclass: pipe_scoreboard
