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

import uvm_pkg::*;

class regs_control_reg extends uvm_reg;
   rand uvm_reg_field enable;
   rand uvm_reg_field mode_select;

   `uvm_object_utils(regs_control_reg)

   function new(string name = "regs_control_reg");
      super.new(name, 32, UVM_NO_COVERAGE);
   endfunction: new

   virtual function void build( );
      this.enable = uvm_reg_field::type_id::create("enable");
      this.enable.configure(this, 16, 0, "RW", 0, 1'h0, 1, 0, 0);

      this.mode_select = uvm_reg_field::type_id::create("mode_select");
      this.mode_select.configure(this, 16, 16, "RW", 0, 1'h0, 1, 0, 0);
   endfunction: build
endclass: regs_control_reg


class regs_status_reg extends uvm_reg;
   rand uvm_reg_field status;

   `uvm_object_utils(regs_status_reg)

   function new(string name = "regs_status_reg");
      super.new(name, 32, UVM_NO_COVERAGE);
   endfunction: new

   virtual function void build( );
      this.status = uvm_reg_field::type_id::create("status");
      this.status.configure(this, 32, 0, "RO", 1, 1'h0, 1, 0, 0);
   endfunction: build
endclass: regs_status_reg

class dut_regs extends uvm_reg_block;
   rand regs_control_reg control_reg;
   rand regs_status_reg status_reg;

   `uvm_object_utils(dut_regs)

   function new(string name = "dut_regs");
      super.new(name, UVM_NO_COVERAGE);
   endfunction: new

   virtual function void build( );
      this.default_map = create_map("dut_reg_map", 0, 4, UVM_LITTLE_ENDIAN, 0);
 
      this.control_reg = regs_control_reg::type_id::create("control_reg");
      this.control_reg.build( );
      this.control_reg.configure(this, null, "");
      this.default_map.add_reg(this.control_reg, `UVM_REG_ADDR_WIDTH'h04, "RW", 0);

      this.status_reg = regs_status_reg::type_id::create("status_reg");
      this.status_reg.build( );
      this.status_reg.configure(this, null, "");
      this.default_map.add_reg(this.status_reg, `UVM_REG_ADDR_WIDTH'h08, "RO", 0);

      lock_model( );
   endfunction: build
  
   
endclass: dut_regs

