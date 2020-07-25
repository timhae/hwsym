#include "tb_fsm_top.h"
#include "tb_timer_top.h"
#include "tb_trafficlight_top.h"
#include <cstdio>
#include <systemc.h>

tb_timer_top *tb_timer_top0 = NULL;

int sc_main(int argc, char *argv[]) {
    sc_set_time_resolution(100, SC_MS);
    tb_timer_top *tb_timer_top0 = new tb_timer_top("tb_timer_top0");
    tb_fsm_top *tb_fsm_top0 = new tb_fsm_top("tb_fsm_top0");
    tb_trafficlight_top *tb_trafficlight_top0 =
        new tb_trafficlight_top("tb_trafficlight_top0");
    sc_start(150, SC_SEC);
    cout << "Finished." << endl;
    return 0;
}
