#ifndef TRAFFICLIGHT_H
#define TRAFFICLIGHT_H

#include "fsm.h"
#include "timer.h"
#include <systemc.h>

SC_MODULE(trafficlight) {
    sc_in_clk clk{"clk"};
    sc_in<int> counter_tram{"counter_tram"};
    sc_in<int> counter_cars_mainstreet{"counter_cars_mainstreet"};
    sc_in<int> counter_cars_sidestreet{"counter_cars_sidestreet"};
    sc_out<bool> trafficlight_mainstreet{"trafficlight_mainstreet"};
    sc_out<bool> trafficlight_sidestreet{"trafficlight_sidestreet"};

    sc_signal<bool> reset;
    sc_signal<bool> timer_30sec;
    sc_signal<bool> timer_60sec;
    sc_signal<bool> timer_120sec;

    timer *timer0 = new timer("timer0");
    fsm *fsm0 = new fsm("fsm0");

    SC_CTOR(trafficlight) {
        timer0->clk(clk);
        timer0->reset(reset);
        timer0->timer_30sec(timer_30sec);
        timer0->timer_60sec(timer_60sec);
        timer0->timer_120sec(timer_120sec);

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
    }
};

#endif
