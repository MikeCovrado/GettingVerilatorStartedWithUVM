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

module top;
   import uvm_pkg::*;
   import pipe_pkg::*;
   
   bit clk;
   bit rst_n;
   
   pipe_if ivif(.clk(clk), .rst_n(rst_n));
   pipe_if ovif(.clk(clk), .rst_n(rst_n));

   
   pipe pipe_top(.clk(clk),
                 .rst_n(rst_n),
                 .i_cf(ivif.cf),
                 .i_en(ivif.enable),
                 .i_data0(ivif.data_in0),
                 .i_data1(ivif.data_in1),
                 .o_data0(ovif.data_out0),
                 .o_data1(ovif.data_out1)
                );

   always #5 clk = ~clk;

   initial begin
       #5 rst_n = 1'b0;
      #25 rst_n = 1'b1;
   end

   assign ovif.enable = ivif.enable;

   initial begin
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get( ) , "*.agent.*" , "in_intf", ivif);
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get( ) , "*.monitor" , "out_intf", ovif);
      run_test( );
   end 

endmodule
