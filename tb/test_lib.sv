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

class base_test extends uvm_test;
   `uvm_component_utils(base_test)

   dut_env env;
   uvm_table_printer printer;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = dut_env::type_id::create("env", this);
      printer = new( );
      printer.knobs.depth = 5;
   endfunction:build_phase

   virtual function void end_of_elaboration_phase(uvm_phase phase);
      `uvm_info(get_type_name( ), $sformatf("Printing the test topology :\n%s", this.sprint(printer)), UVM_LOW)
   endfunction: end_of_elaboration_phase

   virtual task run_phase(uvm_phase phase);
      phase.phase_done.set_drain_time(this, 1500);
   endtask: run_phase

endclass: base_test

class random_test extends base_test;
   `uvm_component_utils(random_test)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      random_sequence seq;

      super.run_phase(phase);
      phase.raise_objection(this);
      seq = random_sequence::type_id::create("seq");
      seq.start(env.penv_in.agent.sequencer);
      phase.drop_objection(this);      
   endtask: run_phase
endclass: random_test

class data0_test extends base_test;
   `uvm_component_utils(data0_test)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      data0_sequence seq;

      super.run_phase(phase);
      phase.raise_objection(this);
      seq = data0_sequence::type_id::create("seq");
      seq.start(env.penv_in.agent.sequencer);
      phase.drop_objection(this);      
   endtask: run_phase
endclass: data0_test

class data1_test extends base_test;
   `uvm_component_utils(data1_test)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      data1_sequence seq;

      super.run_phase(phase);
      phase.raise_objection(this);
      seq = data1_sequence::type_id::create("seq");
      seq.start(env.penv_in.agent.sequencer);
      phase.drop_objection(this);      
   endtask: run_phase
endclass: data1_test

class many_random_test extends base_test;
   `uvm_component_utils(many_random_test)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction: build_phase

   virtual task run_phase(uvm_phase phase);
      many_random_sequence seq;

      super.run_phase(phase);
      phase.raise_objection(this);
      seq = many_random_sequence::type_id::create("seq");
      assert(seq.randomize( ));
      seq.start(env.penv_in.agent.sequencer);
      phase.drop_objection(this);      
   endtask: run_phase
endclass: many_random_test

