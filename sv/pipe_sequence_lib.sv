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

class random_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(random_sequence)

   function new(string name = "random_sequence");
      super.new(name);
      req = new("data_packet");
   endfunction:new

   virtual task body( );
      `uvm_do(req);
   endtask: body

endclass: random_sequence

class data0_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(data0_sequence)

   function new(string name = "data0_sequence");
      super.new(name);
   endfunction:new

   virtual task body( );
`ifndef VERILATOR
      `uvm_do_with(req, {req.data_in0 == 16'h0;})
`else
      req = data_packet::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {req.data_in0 == 16'h0;});
      finish_item(req);
`endif
   endtask: body

endclass: data0_sequence


class data1_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(data1_sequence)
   function new(string name = "data1_sequence");
      super.new(name);
   endfunction:new

   virtual task body( );
      req = data_packet::type_id::create("req");
      start_item(req);
`ifndef VERILATOR
      assert(req.randomize() with {data_in1 == 'hffff;});
`else
      assert(req.randomize());
      req.data_in1 = 16'hffff;
`endif
      finish_item(req);
   endtask: body

endclass: data1_sequence

class many_random_sequence extends uvm_sequence #(data_packet);
   rand int loop;

   constraint limit {loop inside {[5:10]};}
   `uvm_object_utils(many_random_sequence)

   function new(string name = "many_random_sequence");
      super.new(name);
   endfunction:new

   virtual task body( );
      for(int i = 0; i < loop; i++) begin
        `uvm_do(req);
      end
   endtask: body

endclass: many_random_sequence

