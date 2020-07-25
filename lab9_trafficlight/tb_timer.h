#ifndef TB_TIMER_H
#define TB_TIMER_H

#include <systemc.h>

SC_MODULE(tb_timer) {
    sc_in_clk clk;
    sc_in<bool> timer_30sec;
    sc_in<bool> timer_60sec;
    sc_in<bool> timer_120sec;
    sc_out<bool> reset;

    void test() {
        reset = 0;
        wait(9, SC_SEC);
        reset = 1;
        wait(1, SC_SEC);
        reset = 0;
        wait(30, SC_SEC); // 30 sec
        sc_assert(timer_30sec.read() == 1);
        wait(1, SC_SEC);
        sc_assert(timer_30sec.read() == 0);
        wait(29, SC_SEC); // 60 sec
        sc_assert(timer_30sec.read() == 1);
        sc_assert(timer_60sec.read() == 1);
        wait(1, SC_SEC);
        sc_assert(timer_30sec.read() == 0);
        sc_assert(timer_60sec.read() == 0);
        wait(29, SC_SEC); // 90 sec
        sc_assert(timer_30sec.read() == 1);
        wait(1, SC_SEC);
        sc_assert(timer_30sec.read() == 0);
        wait(29, SC_SEC); // 120 sec
        sc_assert(timer_30sec.read() == 1);
        sc_assert(timer_60sec.read() == 1);
        sc_assert(timer_120sec.read() == 1);
        wait(1, SC_SEC);
        sc_assert(timer_30sec.read() == 0);
        sc_assert(timer_60sec.read() == 0);
        sc_assert(timer_120sec.read() == 0);
    }

    SC_CTOR(tb_timer) { SC_THREAD(test); }
};

#endif
