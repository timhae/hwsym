#ifndef TB_TRAFFICLIGHT_H
#define TB_TRAFFICLIGHT_H

#include <systemc.h>

SC_MODULE(tb_trafficlight) {
    sc_in_clk clk;
    sc_out<int> counter_tram;
    sc_out<int> counter_cars_mainstreet;
    sc_out<int> counter_cars_sidestreet;
    sc_in<bool> trafficlight_mainstreet;
    sc_in<bool> trafficlight_sidestreet;

    void test() {
        counter_cars_mainstreet.write(5);
        counter_cars_sidestreet.write(3);
        wait(1, SC_SEC);
        sc_assert(trafficlight_mainstreet.read() == 1);
        sc_assert(trafficlight_sidestreet.read() == 0);
        wait(30, SC_SEC);
        counter_cars_mainstreet.write(2);
        counter_cars_sidestreet.write(7);
        counter_tram.write(2);
        wait(1, SC_SEC);
        sc_assert(trafficlight_mainstreet.read() == 0);
        sc_assert(trafficlight_sidestreet.read() == 0);
        wait(5, SC_SEC);
        sc_assert(trafficlight_mainstreet.read() == 0);
        sc_assert(trafficlight_sidestreet.read() == 1);
        wait(25, SC_SEC);
        counter_tram.write(0);
        wait(7, SC_SEC);
        sc_assert(trafficlight_mainstreet.read() == 0);
        sc_assert(trafficlight_sidestreet.read() == 0);
        wait(5, SC_SEC);
        sc_assert(trafficlight_mainstreet.read() == 1);
        sc_assert(trafficlight_sidestreet.read() == 0);
    }

    SC_CTOR(tb_trafficlight) { SC_THREAD(test); }
};

#endif
