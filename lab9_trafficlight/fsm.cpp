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
	bool duration_main_greater_120 = 0;

	while (true) {
		if (yellow == 0) {
			if (light) {
				if (((counter_cars_mainstreet.read() < counter_cars_sidestreet.read()) and duration_main_greater_30)
					or ((0 < counter_cars_sidestreet.read()) and duration_main_greater_120)
					or (0 < counter_tram.read())) {
					light = 0;
					yellow = 5;
				}
			} else {
				if ((counter_cars_mainstreet.read() > counter_cars_sidestreet.read())
					or true
					or true) {

				}
			}

			if (timer_30sec)
				duration_main_greater_30 = 1;
			if (timer_60sec)
				true;
			if (timer_120sec)
				duration_main_greater_120 = 1;
		} else {
			yellow -= 1;
			duration_main_greater_30 = 0;
			duration_main_greater_120 = 0;
		}
		wait();
	}

}



