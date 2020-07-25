#ifndef TB_TRAFFICLIGHT_TOP_H
#define TB_TRAFFICLIGHT_TOP_H

#include "tb_trafficlight.h"
#include "trafficlight.h"
#include <systemc.h>

SC_MODULE(tb_trafficlight_top) {

    sc_clock clk;

    sc_signal<bool> reset;
    sc_signal<int> counter_tram{"counter_tram"};
    sc_signal<int> counter_cars_mainstreet{"counter_cars_mainstreet"};
    sc_signal<int> counter_cars_sidestreet{"counter_cars_sidestreet"};
    sc_signal<bool> trafficlight_mainstreet{"trafficlight_mainstreet"};
    sc_signal<bool> trafficlight_sidestreet{"trafficlight_sidestreet"};

    tb_trafficlight *tb_trafficlight0;
    trafficlight *trafficlight0;

    sc_trace_file *trace_file;

    SC_CTOR(tb_trafficlight_top) : clk("clk", 1, SC_SEC) {

        tb_trafficlight0 = new tb_trafficlight("tb_trafficlight0");
        tb_trafficlight0->clk(clk);
        tb_trafficlight0->counter_tram(counter_tram);
        tb_trafficlight0->counter_cars_mainstreet(counter_cars_mainstreet);
        tb_trafficlight0->counter_cars_sidestreet(counter_cars_sidestreet);
        tb_trafficlight0->trafficlight_mainstreet(trafficlight_mainstreet);
        tb_trafficlight0->trafficlight_sidestreet(trafficlight_sidestreet);

        trafficlight0 = new trafficlight("trafficlight0");
        trafficlight0->clk(clk);
        trafficlight0->counter_tram(counter_tram);
        trafficlight0->counter_cars_mainstreet(counter_cars_mainstreet);
        trafficlight0->counter_cars_sidestreet(counter_cars_sidestreet);
        trafficlight0->trafficlight_mainstreet(trafficlight_mainstreet);
        trafficlight0->trafficlight_sidestreet(trafficlight_sidestreet);

        trace_file = sc_create_vcd_trace_file("sim_tb_trafficlight");
        sc_trace(trace_file, clk, "clk");
        sc_trace(trace_file, counter_tram, "counter_tram");
        sc_trace(trace_file, counter_cars_mainstreet,
                 "counter_cars_mainstreet");
        sc_trace(trace_file, counter_cars_sidestreet,
                 "counter_cars_sidestreet");
        sc_trace(trace_file, trafficlight_mainstreet,
                 "trafficlight_mainstreet");
        sc_trace(trace_file, trafficlight_sidestreet,
                 "trafficlight_sidestreet");
    }
};

#endif
