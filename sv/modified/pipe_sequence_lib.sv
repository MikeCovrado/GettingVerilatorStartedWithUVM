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


typedef class pipe_sequencer;
class pipe_base_sequence extends uvm_sequence #(data_packet);

  `uvm_declare_p_sequencer(pipe_sequencer)
  `uvm_object_utils(pipe_base_sequence)

  function new(string name="pipe_base_sequence");
    super.new(name);
  endfunction : new

endclass: pipe_base_sequence

//class random_sequence extends uvm_sequence #(data_packet);
class random_sequence extends pipe_base_sequence;
   `uvm_object_utils(random_sequence)

   function new(string name = "random_sequence");
      super.new(name);
      req = new("data_packet");
   endfunction:new

   virtual task body( );
      `uvm_do(req);
   endtask: body

endclass: random_sequence

//class data0_sequence extends uvm_sequence #(data_packet);
class data0_sequence extends pipe_base_sequence;
   `uvm_object_utils(data0_sequence)

   function new(string name = "data0_sequence");
      super.new(name);
   endfunction:new

   virtual task body( );
      `uvm_do_with(req, {req.data_in0 == 16'h0;})
   endtask: body

endclass: data0_sequence


//class data1_sequence extends uvm_sequence #(data_packet);
class data1_sequence extends pipe_base_sequence;
   `uvm_object_utils(data1_sequence)
   function new(string name = "data1_sequence");
      super.new(name);
   endfunction:new

   virtual task body( );
      req = data_packet::type_id::create("req");
      start_item(req);
      assert(req.randomize( ) with {data_in1 == 'hffff;});
      finish_item(req); 
   endtask: body

endclass: data1_sequence

//class many_random_sequence extends uvm_sequence #(data_packet);
class many_random_sequence extends pipe_base_sequence;
   rand int loop;

//   constraint limit {loop inside {[5:p_sequencer.max_count]};}
   constraint limit {loop inside {[5:10]};}
   `uvm_object_utils(many_random_sequence)

   function new(string name = "many_random_sequence");
      super.new(name);
   endfunction:new

   function void post_randomize();
      $display("max_count after randomize = %d", p_sequencer.max_count);
   endfunction

   virtual task body( );
      $display ("max count = %d, loop count = %d", p_sequencer.max_count, loop);
      for(int i = 0; i < loop; i++) begin
        `uvm_do(req);
      end
   endtask: body

endclass: many_random_sequence

