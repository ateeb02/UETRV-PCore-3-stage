// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vcore_tb.h for the primary calling header

#include "verilated.h"

#include "Vcore_tb__Syms.h"
#include "Vcore_tb___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vcore_tb___024root___dump_triggers__stl(Vcore_tb___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vcore_tb___024root___eval_triggers__stl(Vcore_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vcore_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcore_tb___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.at(0U) = (0U == vlSelf->__VstlIterCount);
    vlSelf->__VstlTriggered.at(1U) = (vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__lsu_module__DOT__amo_result_o 
                                      != vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__lsu_module__DOT__amo_result_o);
    vlSelf->__VstlTriggered.at(2U) = (((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req) 
                                       != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req)) 
                                      | ((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req) 
                                         != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req)));
    vlSelf->__VstlTriggered.at(3U) = ((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req) 
                                      != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req));
    vlSelf->__VstlTriggered.at(4U) = ((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req) 
                                      != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req));
    vlSelf->__VstlTriggered.at(5U) = ((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__exc_delegated_req) 
                                      != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__exc_delegated_req));
    vlSelf->__VstlTriggered.at(6U) = ((IData)(vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__en_ld_st_vaddr_next) 
                                      != (IData)(vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__en_ld_st_vaddr_next));
    vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__lsu_module__DOT__amo_result_o 
        = vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__lsu_module__DOT__amo_result_o;
    vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req 
        = vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__s_mode_exc_req;
    vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req 
        = vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__m_mode_exc_req;
    vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__exc_delegated_req 
        = vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__exc_delegated_req;
    vlSelf->__Vtrigrprev__TOP__core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__en_ld_st_vaddr_next 
        = vlSelf->core_tb__DOT__dut__DOT__pipeline_top_module__DOT__csr_module__DOT__en_ld_st_vaddr_next;
    if (VL_UNLIKELY((1U & (~ (IData)(vlSelf->__VstlDidInit))))) {
        vlSelf->__VstlDidInit = 1U;
        vlSelf->__VstlTriggered.at(1U) = 1U;
        vlSelf->__VstlTriggered.at(2U) = 1U;
        vlSelf->__VstlTriggered.at(3U) = 1U;
        vlSelf->__VstlTriggered.at(4U) = 1U;
        vlSelf->__VstlTriggered.at(5U) = 1U;
        vlSelf->__VstlTriggered.at(6U) = 1U;
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vcore_tb___024root___dump_triggers__stl(vlSelf);
    }
#endif
}