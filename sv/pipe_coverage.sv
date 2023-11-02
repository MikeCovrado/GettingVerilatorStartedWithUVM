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

class pipe_coverage extends uvm_subscriber #(data_packet);

   data_packet pkt;
   int count;

   `uvm_component_utils(pipe_coverage)

   covergroup cg;
      option.per_instance = 1;
      cov_cf:    coverpoint pkt.cf;
      cov_en:    coverpoint pkt.enable;
      cov_ino:   coverpoint pkt.data_in0;
      cov_in1:   coverpoint pkt.data_in1;
      cov_out0:  coverpoint pkt.data_out0;
      cov_out1:  coverpoint pkt.data_out1;
      cov_del:   coverpoint pkt.delay;
   endgroup: cg

   function new(string name, uvm_component parent);
      super.new(name, parent);
      cg = new( );
   endfunction: new

   function void write(data_packet t);
      pkt = t;
      count++;
      cg.sample( );
   endfunction: write

   virtual function void extract_phase(uvm_phase phase);
      `uvm_info(get_type_name( ), $sformatf("Number of coverage packets collected = %0d", count), UVM_LOW)
      `uvm_info(get_type_name( ), $sformatf("Current coverage  = %f", cg.get_coverage( )), UVM_LOW)
   endfunction: extract_phase
endclass: pipe_coverage
