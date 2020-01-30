#ifndef SRC_TB_FSM_TOP_H_
#define SRC_TB_FSM_TOP_H_

#include "systemc.h"
#include "fsm.h"
#include "tb_fsm.h"

struct tb_fsm_top : sc_module {

	sc_clock clk;

	sc_signal<bool> reset;
	sc_signal<bool> timer_30sec, timer_60sec, timer_120sec, trafficlight_mainstreet, trafficlight_sidestreet;
	sc_signal<int> counter_tram, counter_cars_mainstreet, counter_cars_sidestreet;

	fsm* fsm0;
	tb_fsm* tb_fsm0;
	sc_trace_file *trace_file;

	tb_fsm_top(sc_module_name name);

	SC_HAS_PROCESS(tb_fsm_top);

};




#endif
