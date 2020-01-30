#ifndef SRC_TB_FSM_H_
#define SRC_TB_FSM_H_

#include "systemc.h"

struct tb_fsm : sc_module {
	sc_in_clk clk;
	sc_out<bool> timer_30sec;
	sc_out<bool> timer_60sec;
	sc_out<bool> timer_120sec;
	sc_out<int> counter_tram;
	sc_out<int> counter_cars_mainstreet;
	sc_out<int> counter_cars_sidestreet;
	sc_in<bool> trafficlight_mainstreet;
	sc_in<bool> trafficlight_sidestreet;
	sc_in<bool> timer_reset;

	tb_fsm(sc_module_name name);
	void test();

	SC_HAS_PROCESS(tb_fsm);
};




#endif /* SRC_TB_FSM_H_ */
