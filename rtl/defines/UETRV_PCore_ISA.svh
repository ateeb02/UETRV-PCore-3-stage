`ifndef UETRV_PCORE_ISA
`define UETRV_PCORE_ISA


//------------------------------------------------------------------------------
// ISA related definitions
//------------------------------------------------------------------------------
typedef enum logic [4:0] {
    OPCODE_LOAD_INST      = 5'b00000,
    OPCODE_STORE_INST     = 5'b01000,
    OPCODE_MEM_FENCE_INST = 5'b00011,
    OPCODE_IMM_INST       = 5'b00100,
    OPCODE_AUIPC_INST     = 5'b00101,
    OPCODE_ARITH_INST     = 5'b01100,
    OPCODE_LUI_INST       = 5'b01101,
    OPCODE_BRANCH_INST    = 5'b11000,
    OPCODE_JALR_INST      = 5'b11001,
    OPCODE_JAL_INST       = 5'b11011,
    OPCODE_SYSTEM_INST    = 5'b11100
} type_rv_opcode_e;

// ALU operand 1 selection
typedef enum logic {
    ALU_OPR1_REG,          // opr1 = rs1
    ALU_OPR1_PC            // opr1 = program counter
} type_alu_opr1_sel_e;

// ALU operand 2 selection
typedef enum logic {
    ALU_OPR2_REG,          // opr2 = rs2
    ALU_OPR2_IMM           // opr2 = immediate value
} type_alu_opr2_sel_e;

// ALU comparison operand 2 selection
typedef enum logic {
    ALU_CMP_OPR2_REG,          // opr2 = rs2
    ALU_CMP_OPR2_IMM           // opr2 = immediate value
} type_alu_cmp_opr2_sel_e;


typedef enum logic [4:0] {
    ALU_OPS_NONE  = '0,   // ALU is idle 
    ALU_OPS_ADD,          // oprnd1 + oprnd2
    ALU_OPS_SUB,          // oprnd1 - oprnd2
    ALU_OPS_AND,          // oprnd1 & oprnd2
    ALU_OPS_OR,           // oprnd1 | oprnd2
    ALU_OPS_XOR,          // oprnd1 ^ oprnd2
    ALU_OPS_SLT,          // oprnd1 s< oprnd2
    ALU_OPS_SLTU,         // oprnd1 u< oprnd2
    ALU_OPS_SLL,          // oprnd1 << oprnd2
    ALU_OPS_SRL,          // oprnd1 >> oprnd2
    ALU_OPS_SRA,          // oprnd1 >>> oprnd2
    ALU_OPS_BRANCH,       // pc + offset
    ALU_OPS_COPY_OPR2     // Copy operand 2 to ALU output

`ifdef RISCV_M_EXT
    ,
    ALU_OPS_MUL,          // low((oprnd1) * (oprnd2))
    ALU_OPS_MULHU,        // high((oprnd1) * (oprnd2))
    ALU_OPS_MULHSU,       // high(oprnd1 * (oprnd2))
    ALU_OPS_MULH,         // high(oprnd1 * oprnd2)
    ALU_OPS_DIV,          // oprnd1 s/ oprnd2
    ALU_OPS_DIVU,         // oprnd1 u/ oprnd2
    ALU_OPS_REM,          // oprnd1 s% oprnd2
    ALU_OPS_REMU          // oprnd1 u% oprnd2
`endif  // RISCV_M_EXT
} type_alu_ops_sel_e;

typedef enum logic [2:0] {
// Operations for conditional branch instructions
    BR_NONE = '0,   // 
    BR_EQ,          // oprnd1 = oprnd2 
    BR_NE,          // oprnd1 != oprnd2
    BR_GE,          // oprnd1 s>= oprnd2
    BR_GEU,         // oprnd1 u>= oprnd2
    BR_LT,          // oprnd1 s< oprnd2
    BR_LTU          // oprnd1 u< oprnd2
} type_br_ops_sel_e;

//-----------------------------------------------------------------------------
// MEM load/store operation types
//-----------------------------------------------------------------------------
typedef enum logic [2:0] {
    MEM_LD_OPS_NONE = '0,
    MEM_LD_OPS_LB,
    MEM_LD_OPS_LBU,
    MEM_LD_OPS_LH,
    MEM_LD_OPS_LHU,
    MEM_LD_OPS_LW
} type_mem_ld_ops_e;

typedef enum logic [1:0] {
    MEM_ST_OPS_NONE = '0,
    MEM_ST_OPS_SB,
    MEM_ST_OPS_SH,
    MEM_ST_OPS_SW
} type_mem_st_ops_e;

// Writeback source selection for register file 
typedef enum logic [2:0] {
    RD_WB_NONE = '0,
    RD_WB_ALU,                           // Writeback ALU result
    RD_WB_INC_PC,                        // Writeback PC (return address) for JAL/JALR
    RD_WB_MEM,                           // Writeback selection for Load operation from DMEM
    RD_WB_CSR                            // Writeback for reading CSR
} type_rd_wb_sel_e;

// Decode-2-Execute data and control signals
typedef struct packed {                            
    logic [`XLEN-1:0]                rs1_data;     
    logic [`XLEN-1:0]                rs2_data;
    logic [`XLEN-1:0]                instr;
    logic [`XLEN-1:0]                pc;
    logic [`XLEN-1:0]                imm;     
} type_id2exe_data_s;

typedef struct packed {                           
    type_rd_wb_sel_e                 rd_wb_sel;
    type_alu_ops_sel_e               alu_ops;
    type_alu_opr1_sel_e              alu_opr1_sel;
    type_alu_opr2_sel_e              alu_opr2_sel;
    type_alu_cmp_opr2_sel_e          alu_cmp_opr2_sel;
    type_mem_ld_ops_e                mem_ld_ops;
    type_mem_st_ops_e                mem_st_ops;
    type_br_ops_sel_e                branch_ops;
    logic                            rd_wr_req;
    logic                            jump_req;
    logic                            branch_req;
    logic                            mret_req;
    logic                            fencei_req;
    logic                            wfi_req;
} type_id2exe_ctrl_s;

// Execute-2-Memory data and control signals
typedef struct packed {                            
    logic [`XLEN-1:0]                alu_result;
    logic [`XLEN-1:0]                instr;
    logic [`XLEN-1:0]                pc;
    logic [`XLEN-1:0]                rs2_data;     
} type_exe2mem_data_s;

typedef struct packed {                           
    type_rd_wb_sel_e                 rd_wb_sel;
    type_mem_ld_ops_e                mem_ld_ops;
    type_mem_st_ops_e                mem_st_ops;
    logic                            rd_wr_req;
    logic                            jump_req;
    logic                            branch_req;
    logic                            mret_req;
    logic                            fencei_req;
    logic                            wfi_req;
} type_exe2mem_ctrl_s;

// Memory-2-Writeback data and control signals
typedef struct packed {                            
    logic [`XLEN-1:0]                alu_result;
    logic [`XLEN-1:0]                csr_data;
    logic [`XLEN-1:0]                pc;
    logic [`XLEN-1:0]                dmem_rdata;  
    logic [`RF_AWIDTH-1:0]           rd_addr;    
} type_mem2wb_data_s;

typedef struct packed {                           
    type_rd_wb_sel_e                 rd_wb_sel;
    logic                            rd_wr_req;
} type_mem2wb_ctrl_s;


// Data memory interface
typedef struct packed {                            
    logic [`XLEN-1:0]                addr;
    logic [`XLEN-1:0]                data_wr;
    logic [3:0]                      mask;  
    logic                            wr;  
    logic                            cs;  
} type_signal_to_dmem_s;

typedef struct packed {                            
    logic [`XLEN-1:0]                data_rd;
  
} type_signal_from_dmem_s;


// Execute-2-Fetch data and control signals
typedef struct packed {                            
    logic [`XLEN-1:0]                alu_pc;
    logic                            jump_br_taken;  
} type_exe2if_fb_s;



`endif // UETRV_PCORE_ISA