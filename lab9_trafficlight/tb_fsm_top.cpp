#include "systemc.h"
#include "tb_fsm_top.h"

tb_fsm_top::tb_fsm_top(sc_module_name name) : clk("clk", 1, SC_SEC) {
	fsm0 = new fsm("fsm0");
	tb_fsm0 = new tb_fsm("tb_fsm0");

	fsm0->clk(clk);
	fsm0->timer_30sec(timer_30sec);
	fsm0->timer_60sec(timer_60sec);
	fsm0->timer_120sec(timer_120sec);
	fsm0->counter_tram(counter_tram);
	fsm0->counter_cars_mainstreet(counter_cars_mainstreet);
	fsm0->counter_cars_sidestreet(counter_cars_sidestreet);
	fsm0->trafficlight_mainstreet(trafficlight_mainstreet);
	fsm0->trafficlight_sidestreet(trafficlight_sidestreet);
	fsm0->timer_reset(reset);

	tb_fsm0->clk(clk);
	tb_fsm0->timer_30sec(timer_30sec);
	tb_fsm0->timer_60sec(timer_60sec);
	tb_fsm0->timer_120sec(timer_120sec);
	tb_fsm0->counter_tram(counter_tram);
	tb_fsm0->counter_cars_mainstreet(counter_cars_mainstreet);
	tb_fsm0->counter_cars_sidestreet(counter_cars_sidestreet);
	tb_fsm0->trafficlight_mainstreet(trafficlight_mainstreet);
	tb_fsm0->trafficlight_sidestreet(trafficlight_sidestreet);
	tb_fsm0->timer_reset(reset);

	trace_file = sc_create_vcd_trace_file("sim_tb_fsm");
	sc_trace(trace_file, clk,"clk");
	sc_trace(trace_file, reset, "reset");
	sc_trace(trace_file, timer_30sec, "timer_30sec");
	sc_trace(trace_file, timer_60sec, "timer_60sec");
	sc_trace(trace_file, timer_120sec, "timer_120sec");
	sc_trace(trace_file, counter_tram, "counter_tram");
	sc_trace(trace_file, counter_cars_mainstreet, "counter_cars_mainstreet");
	sc_trace(trace_file, trafficlight_mainstreet, "trafficlight_mainstreet");
	sc_trace(trace_file, trafficlight_sidestreet, "trafficlight_sidestreet");
	sc_trace(trace_file, reset, "reset");

}




