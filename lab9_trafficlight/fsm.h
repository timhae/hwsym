#include "systemc.h"

#ifndef FSM_H_
#define FSM_H_
struct fsm : sc_module {
	sc_in<bool> clk;
	sc_in<bool> timer_30sec;
	sc_in<bool> timer_60sec;
	sc_in<bool> timer_120sec;
	sc_in<int> counter_tram;
	sc_in<int> counter_cars_mainstreet;
	sc_in<int> counter_cars_sidestreet;
	sc_out<bool> trafficlight_mainstreet;
	sc_out<bool> trafficlight_sidestreet;
	sc_out<bool> timer_reset;

	fsm(sc_module_name name);
	SC_HAS_PROCESS(fsm);
	void process_state();
};




#endif /* FSM_H_ */
