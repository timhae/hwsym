#include "systemc.h"
#include "tb_timer_top.h"

tb_timer_top* tb_timer_top0 = NULL;

int sc_main(int argc, char* argv[]) {
	tb_timer_top* tb_timer_top0 = new tb_timer_top("tb_timer_top0");
	//sc_set_time_resolution(100, SC_MS);
	sc_start(125, SC_SEC);
	cout << "Finished." << endl;
        return 0;
	
}
