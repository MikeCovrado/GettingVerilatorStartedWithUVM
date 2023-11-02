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

module pipe( clk, 
            rst_n,
            i_cf,
            i_en,
            i_data0,
            i_data1,
            o_data0,
            o_data1
          );

   input         clk;
   input         rst_n;
   input   [1:0] i_cf;
   input         i_en;
   input  [15:0] i_data0;
   input  [15:0] i_data1;

   output [15:0] o_data0;
   output [15:0] o_data1;

   wire        clk;
   wire        rst_n;
   wire  [1:0] i_cf;
   wire        i_en;
   wire [15:0] i_data0;
   wire [15:0] i_data1;

   reg  [15:0] o_data0;
   reg  [15:0] o_data1;

   reg  [15:0] data_0;
   reg  [15:0] data_1;

   //Store the input data and check to see if it is 16'h0000 or 16'hFFFF
   //If not, multiply by correction factor

   always @(posedge clk) begin
      if(!rst_n) begin
         data_0 <= 16'h0000;
         data_1 <= 16'h0000;
      end
      else begin
         if(i_en) begin
            if((i_data0 == 16'h0000) || (i_data0 == 16'hFFFF)) begin
               data_0 <= i_data0;
            end
            else begin
               data_0 <= i_data0 * i_cf;
            end
            if((i_data1 == 16'h0000) || (i_data1 == 16'hFFFF)) begin
               data_1 <= i_data1;
            end
            else begin
               data_1 <= i_data1 * i_cf;
            end
         end
      end
   end

   always @(posedge clk) begin
      o_data0 <= data_0;
      o_data1 <= data_1;
   end
endmodule
