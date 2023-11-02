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

class pipe_sequencer extends uvm_sequencer #(data_packet);

   int max_count = 100;

  `uvm_component_utils_begin(pipe_sequencer)
      `uvm_field_int(max_count, UVM_ALL_ON)
  `uvm_component_utils_end
 
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new
endclass: pipe_sequencer
