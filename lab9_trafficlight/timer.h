#ifndef TIMER_H
#define TIMER_H

#include <systemc.h>

SC_MODULE(timer) {
    sc_in_clk clk;
    sc_in<bool> reset;
    sc_out<bool> timer_30sec;
    sc_out<bool> timer_60sec;
    sc_out<bool> timer_120sec;

    void time() {
        // i for 30 sec, j for 60 sec, k for 120 sec
        int i = 0;
        int j = 0;
        int k = 0;
        while (true) {
            timer_30sec.write(0);
            timer_60sec.write(0);
            timer_120sec.write(0);
            i++;
            j++;
            k++;
            if (reset.read() == 1) {
                i = 0;
                j = 0;
                k = 0;
            }
            if (i == 30) {
                timer_30sec.write(1);
                i = 0;
            }
            if (j == 60) {
                timer_60sec.write(1);
                j = 0;
            }
            if (k == 120) {
                timer_120sec.write(1);
                k = 0;
            }
            wait();
        }
    }

    SC_CTOR(timer) {
        SC_THREAD(time);
        dont_initialize();
        sensitive << clk.pos();
    }
};

#endif
