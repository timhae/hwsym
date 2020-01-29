#include "fsm.h"
#include "systemc.h"

fsm::fsm(sc_module_name name) {
	SC_THREAD(process_state);
	sensitive << clk.pos();

}

void fsm::process_state() {
	bool light = 1; // main street green, side street red
	int yellow = 0;
	bool duration_main_greater_30 = 0;
	bool duration_main_greater_60 = 0;
	bool duration_main_greater_120 = 0;
	bool soon_light = 1;

	while (true) {
		if (yellow == 0) {
			if (light) {
				if (((counter_cars_mainstreet.read() < counter_cars_sidestreet.read()) and duration_main_greater_60)
					or ((0 < counter_cars_sidestreet.read()) and duration_main_greater_120)
					or (0 < counter_tram.read())) {
					soon_light = 0;
					trafficlight_mainstreet = 0;
					yellow = 5;
				}
			} else {
				if ((counter_cars_mainstreet.read() > counter_cars_sidestreet.read())
					or (duration_main_greater_30 and counter_tram.read() == 0)
					or (counter_cars_sidestreet.read() == 0)) {
					soon_light = 1;
					trafficlight_sidestreet = 0;
					yellow = 5;
				}
			}

			if (timer_30sec)
				duration_main_greater_30 = 1;
			if (timer_60sec)
				duration_main_greater_60 = 1;
			if (timer_120sec)
				duration_main_greater_120 = 1;
			if (light) {
						trafficlight_mainstreet = 1;
						trafficlight_sidestreet = 0;
					} else {
						trafficlight_mainstreet = 0;
						trafficlight_sidestreet = 1;
					}
		} else {
			yellow -= 1;
			duration_main_greater_30 = 0;
			duration_main_greater_60 = 0;
			duration_main_greater_120 = 0;
			timer_reset = 1;
			if (yellow == 0) {
				timer_reset = 0;
				if (soon_light) {
					light = 1;
				} else {
					light = 0;
				}
			}
		}
		wait();
	}

}



