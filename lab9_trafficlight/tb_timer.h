/*
 * timer_tb.h
 *
 *  Created on: Jan 21, 2020
 *      Author: hms_5ds
 */

#ifndef TIMER_TB_H_
#define TIMER_TB_H_
#include "systemc.h"
#include "timer.h"

SC_MODULE(tb_timer) {
	sc_in_clk clk;
	sc_in<bool> timer_30sec;
	sc_in<bool> timer_60sec;
	sc_in<bool> timer_120sec;
	sc_out<bool> reset;


	void test();

	SC_CTOR(tb_timer) {
		SC_THREAD(test);
	}
};




#endif /* TIMER_TB_H_ */
