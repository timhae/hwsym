/*
 * tb_timer_top.h
 *
 *  Created on: Nov 20, 2018
 *      Author: Julian Haase
 */

#ifndef TB_TIMER_TOP_H_
#define TB_TIMER_TOP_H_

#include <systemc.h>
#include "timer.h"
#include "tb_timer.h"

SC_MODULE(tb_timer_top) {

	sc_clock clk;

	sc_signal<bool> reset;
	sc_signal<bool> timer_30sec;
	sc_signal<bool> timer_60sec;
	sc_signal<bool> timer_120sec;

	tb_timer 	*tb_timer0;
	timer 		*timer0;

    sc_trace_file *trace_file;

    SC_CTOR(tb_timer_top): clk("clk",1,SC_SEC) {

    	cout << "tb_timer_top::constructor()" << endl;

    	tb_timer0 = new tb_timer("tb_timer0");
    	tb_timer0->clk(clk);
    	tb_timer0->reset(reset);
    	tb_timer0->timer_30sec(timer_30sec);
    	tb_timer0->timer_60sec(timer_60sec);
    	tb_timer0->timer_120sec(timer_120sec);

    	timer0 = new timer("timer0");
    	timer0->clk(clk);
    	timer0->reset(reset);
    	timer0->timer_30sec(timer_30sec);
    	timer0->timer_60sec(timer_60sec);
    	timer0->timer_120sec(timer_120sec);

    	trace_file = sc_create_vcd_trace_file("sim_tb_timer");
    	sc_trace(trace_file, clk,"clk");
    	sc_trace(trace_file, reset,"reset");
    	sc_trace(trace_file, timer_30sec,"timer_30sec");
    	sc_trace(trace_file, timer_60sec,"timer_60sec");
    	sc_trace(trace_file, timer_120sec,"timer_120sec");

    }	// End of Constructor

    ~tb_timer_top(){

    	cout << "tb_timer_top::destructor()" << endl;

    	delete tb_timer0;
    	delete timer0;
    	sc_close_vcd_trace_file(trace_file);

    }	// End of Destructor

}; // End of Module tb_timer_top

#endif /* TB_TIMER_TOP_H_ */
