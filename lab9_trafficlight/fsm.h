#ifndef FSM_H
#define FSM_H

#include <systemc.h>

SC_MODULE(fsm) {
    sc_in<bool> clk{"clk"};
    sc_in<bool> timer_30sec{"timer_30sec"};
    sc_in<bool> timer_60sec{"timer_60sec"};
    sc_in<bool> timer_120sec{"timer_120sec"};
    sc_in<int> counter_tram{"counter_tram"};
    sc_in<int> counter_cars_mainstreet{"counter_cars_mainstreet"};
    sc_in<int> counter_cars_sidestreet{"counter_cars_sidestreet"};
    sc_out<bool> trafficlight_mainstreet{
        "trafficlight_mainstreet"}; // 0: red, 1: green
    sc_out<bool> trafficlight_sidestreet{"trafficlight_sidestreet"};
    sc_out<bool> timer_reset{"timer_reset"};

    void process_state() {
        bool state = 0; // 0: main street green, side street red
        trafficlight_mainstreet.write(1);
        trafficlight_sidestreet.write(0);
        bool main_green_over_30 = 0;
        bool main_green_over_60 = 0;
        bool main_green_over_120 = 0;
        bool transition = 0;

        while (true) {
            if (state == 1) { // main red
                if (counter_cars_mainstreet.read() >
                        counter_cars_sidestreet.read() ||
                    (main_green_over_30 && counter_tram.read() == 0) ||
                    counter_cars_sidestreet.read() == 0) { // cond 1
                    transition = 1;
                }
            }
            if (state == 0) { // side red
                if ((counter_cars_sidestreet.read() >
                         counter_cars_mainstreet.read() &&
                     main_green_over_60) ||
                    (counter_cars_sidestreet.read() > 0 &&
                     main_green_over_120) ||
                    counter_tram.read() > 0) { // cond 2
                    transition = 1;
                }
            }
            if (transition == 1) { // cond 3
                // "yellow"
                trafficlight_mainstreet.write(0);
                trafficlight_sidestreet.write(0);
                wait(5, SC_SEC);
                trafficlight_mainstreet.write(state);
                trafficlight_sidestreet.write(state ^ 1);
                state = state ^ 1;
                transition = 0;
                timer_reset.write(1);
                main_green_over_30 = 0;
                main_green_over_60 = 0;
                main_green_over_120 = 0;
                wait(1, SC_SEC);
                timer_reset.write(0);
            }
            if (timer_30sec.read() == 1)
                main_green_over_30 = 1;
            if (timer_60sec.read() == 1)
                main_green_over_60 = 1;
            if (timer_120sec.read() == 1)
                main_green_over_120 = 1;
            wait();
        }
    }

    SC_CTOR(fsm) {
        SC_THREAD(process_state);
        sensitive << clk.pos();
        dont_initialize();
    }
};

#endif
