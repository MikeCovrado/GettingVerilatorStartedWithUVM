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

class pipe_driver extends uvm_driver #(data_packet);
   virtual pipe_if vif;

   `uvm_component_utils(pipe_driver)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual pipe_if)::get(this, "", "in_intf", vif))
         `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name( ), ".vif"})
      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction

   virtual task run_phase(uvm_phase phase);
      fork
         reset( );
         get_and_drive( );
      join
   endtask: run_phase

   virtual task reset( );
      `uvm_info(get_type_name( ), "Resetting signals ... ", UVM_LOW)
      forever begin
         @(negedge vif.rst_n);
         vif.cf = 2'b0;
         vif.data_in0 = 15'b0;
         vif.data_in1 = 15'b0;
         vif.enable = 1'b0;
      end
   endtask: reset

   virtual task get_and_drive( );
      forever begin
         @(posedge vif.rst_n);
         while(vif.rst_n != 1'b0) begin
            seq_item_port.get_next_item(req);
            drive_packet(req);
            seq_item_port.item_done( );
         end
      end 
   endtask: get_and_drive

   virtual task drive_packet(data_packet pkt);
      vif.enable = 1'b0;
      repeat(pkt.delay) @(posedge vif.clk);
      vif.enable = pkt.enable;
      vif.cf = pkt.cf;
      vif.data_in0 = pkt.data_in0;
      vif.data_in1 = pkt.data_in1;
      @(posedge vif.clk);
      vif.enable = 1'b0;
   endtask

endclass:pipe_driver
