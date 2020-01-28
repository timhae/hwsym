#include "systemc.h"
#include "timer.h"

timer::timer(sc_module_name name) {
	SC_HAS_PROCESS(timer);
	SC_THREAD(time);
	sensitive << clk.pos();
	dont_initialize();
}

void timer::time() {
	// i for 30 sec, j for 60 sec, k for 120 sec
	int i, j, k;
	i = -1; j = -1; k = -1;
	while(true) {
		if (reset) {
			i = -1;
			j = -1;
			k = -1;
		}
		timer_30sec = 0;
		timer_60sec = 0;
		timer_120sec = 0;
		i++;
		j++;
		k++;
		if (i == 30) {
			timer_30sec = 1;
			i = 0;
		}

		if (j == 60) {
			timer_60sec = 1;
			j = 0;
		}

		if (k == 120) {
			timer_120sec = 1;
			k = 0;
		}

		wait();
	}
}
