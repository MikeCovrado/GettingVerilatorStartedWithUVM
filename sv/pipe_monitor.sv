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

class pipe_monitor extends uvm_monitor;
   virtual pipe_if vif;
   string monitor_intf;
   int num_pkts;

   uvm_analysis_port #(data_packet) item_collected_port;
   data_packet data_collected;
   data_packet data_clone;

   `uvm_component_utils(pipe_monitor)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(string)::get(this, "", "monitor_intf", monitor_intf))
         `uvm_fatal("NOSTRING", {"Need interface name for: ", get_full_name( ), ".monitor_intf"})

      `uvm_info(get_type_name( ), $sformatf("INTERFACE USED = %0s", monitor_intf), UVM_LOW)
      if(!uvm_config_db#(virtual pipe_if)::get(this, "", monitor_intf, vif))
         `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name( ), ".vif"})
      
      item_collected_port = new("item_collected_port", this);      
      data_collected = data_packet::type_id::create("data_collected");
      data_clone = data_packet::type_id::create("data_clone");

      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      collect_data( );
   endtask: run_phase

   virtual task collect_data( );
      forever begin
         wait(vif.rst_n) 
         data_collected.cf = vif.cf;
         data_collected.data_in0 = vif.data_in0;
         data_collected.data_in1 = vif.data_in1;
         repeat(2) @(posedge vif.clk);
         data_collected.data_out0 = vif.data_out0;
         data_collected.data_out1 = vif.data_out1;
         $cast(data_clone, data_collected.clone( ));
         item_collected_port.write(data_clone);
         num_pkts++;
      end 
   endtask: collect_data

   virtual function void report_phase(uvm_phase phase);
      //`uvm_info(get_type_name( ), $psprintf("REPORT: COLLECTED PACKETS = %0d", num_pkts), UVM_LOW)
      `uvm_info(get_type_name( ), $sformatf("REPORT: COLLECTED PACKETS = %0d", num_pkts), UVM_LOW)
   endfunction: report_phase

  
endclass: pipe_monitor
