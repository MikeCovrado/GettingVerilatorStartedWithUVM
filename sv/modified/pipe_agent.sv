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

class pipe_agent extends uvm_agent;
//   protected uvm_active_passive_enum is_active = UVM_ACTIVE;
   protected uvm_active_passive_enum active_passive = UVM_ACTIVE;

   pipe_sequencer sequencer;
   pipe_driver    driver;
   pipe_monitor   monitor;

   `uvm_component_utils_begin(pipe_agent)
      `uvm_field_enum(uvm_active_passive_enum, active_passive, UVM_ALL_ON)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
   `uvm_component_utils_end

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "active_passive", active_passive))
         `uvm_info(get_full_name( ), "Didn't get the active_passive field.", UVM_LOW)

      if(is_active == UVM_ACTIVE) begin
         sequencer = pipe_sequencer::type_id::create("sequencer", this);
         driver = pipe_driver::type_id::create("driver", this);
      end
      
      monitor = pipe_monitor::type_id::create("monitor", this);
 
      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      if(is_active == UVM_ACTIVE)
         begin
            `uvm_info(get_full_name( ), "Connecting the sequence item export in the active agent.", UVM_LOW)
             driver.seq_item_port.connect(sequencer.seq_item_export);
         end
      `uvm_info(get_full_name( ), "Connect stage complete.", UVM_LOW)
      if(is_active == UVM_ACTIVE)
          `uvm_info(get_full_name( ), "is_active=UVM_ACTIVE.", UVM_LOW)
      if(is_active == UVM_PASSIVE)
          `uvm_info(get_full_name( ), "is_active=UVM_PASSIVE.", UVM_LOW)
      if(super.is_active == UVM_ACTIVE)
          `uvm_info(get_full_name( ), "super.is_active=UVM_ACTIVE.", UVM_LOW)
      if(super.is_active == UVM_PASSIVE)
          `uvm_info(get_full_name( ), "super.is_active=UVM_PASSIVE.", UVM_LOW)
   endfunction: connect_phase 
endclass: pipe_agent
