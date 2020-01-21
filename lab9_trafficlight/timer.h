#ifndef TIMER_H
#define TIMER_H

#include "systemc.h"

SC_MODULE(timer) {
	sc_in_clk clk;
	sc_in<bool> reset;
	sc_out<bool> timer_30sec;
	sc_out<bool> timer_60sec;
	sc_out<bool> timer_120sec;

	timer(sc_module_name name);
	void time();
};

#endif
