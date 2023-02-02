`ifndef VERILATOR
`include "../defines/UETRV_PCore_ISA.svh"
`include "../defines/MMU_defs.svh"
`else
`include "UETRV_PCore_ISA.svh"
`include "MMU_defs.svh"
`endif

module mem_top (

    input   logic                                  rst_n,                      // reset
    input   logic                                  clk,                        // clock

  // Instruction memory interface
    input  wire type_if2imem_s                      if2imem_i,                 // Bus interface from IF to imem 
    output type_imem2if_s                           imem2if_o,                 // From imem to IF

  // MMU interface
    input  wire type_mmu2dmem_s                     mmu2dmem_i,                 // Interface from MMU 
    output type_dmem2mmu_s                          dmem2mmu_o,                 // From data memory to MMU

  // DBus <---> Data memory interface
    input   wire type_dbus2peri_s                   dbus2dmem_i,               // Data memory input signals
    output  type_peri2dbus_s                        dmem2dbus_o,               // Data memory output signals
    output  type_peri2dbus_s                        bmem2dbus_o,               // Boot memory output signals

 // Selection signal from address decoder of dbus interconnect 
    input   logic                                   dmem_sel_i,
    input   logic                                   bmem_sel_i
);


// Local signals
type_if2imem_s                          if2imem;            // Instruction memory address
type_imem2if_s                          imem2if; 
type_imem2if_s                          bmem2if;  

type_mmu2dmem_s                         mmu2dmem;               
type_dmem2mmu_s                         dmem2mmu;

type_dbus2peri_s                        dbus2peri;
type_peri2dbus_s                        dmem2dbus;          // Signals from data memory
type_peri2dbus_s                        bmem2dbus;  

// Peripheral module selection lines from the address decoder
logic                                   dmem_sel;
logic                                   bmem_sel;
logic                                   bmem_iaddr_match;

// Signal assignments
assign if2imem   = if2imem_i;
assign mmu2dmem  = mmu2dmem_i;
assign dbus2peri = dbus2dmem_i;
assign dmem_sel  = dmem_sel_i;
assign bmem_sel  = bmem_sel_i;


assign bmem_iaddr_match = (if2imem.addr[`BMEM_SEL_ADDR_HIGH:`BMEM_SEL_ADDR_LOW] == `BMEM_ADDR_MATCH);
//assign bmem_daddr_match = (bmem_d_addr[`BMEM_SEL_ADDR_HIGH:`BMEM_SEL_ADDR_LOW] == `BMEM_ADDR_MATCH);


bmem_interface bmem_interface_module (
    .rst_n                (rst_n    ),
    .clk                  (clk      ),

    // Data memory interface signals 
    .dbus2bmem_i          (dbus2peri),
    .bmem_d_sel_i         (bmem_sel),
    .bmem2dbus_o          (bmem2dbus),

   // Instruction memory interface signals 
    .if2bmem_i            (if2imem),
    .bmem_iaddr_match_i   (bmem_iaddr_match),
    .bmem2if_o            (bmem2if)
    
);


dualport_mem dualport_mem_module (
    .rst_n                (rst_n    ),
    .clk                  (clk      ),

    // Data memory interface signals 
    .dbus2dmem_i          (dbus2peri),
    .dmem_sel_i           (dmem_sel),
    .dmem2dbus_o          (dmem2dbus),

   // MMU <---> data memory interface signals 
    .mmu2dmem_i           (mmu2dmem),
    .dmem2mmu_o           (dmem2mmu),

   // Instruction memory interface signals 
    .if2imem_i            (if2imem),
    .imem_sel_i           (~bmem_iaddr_match),
    .imem2if_o            (imem2if)
);


assign imem2if_o   = bmem2if.ack ? bmem2if : imem2if; 
assign bmem2dbus_o = bmem2dbus;
assign dmem2dbus_o = dmem2dbus;  
assign dmem2mmu_o  = dmem2mmu; 

endmodule : mem_top

