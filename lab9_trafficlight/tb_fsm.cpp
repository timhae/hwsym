#include "systemc.h"
#include "tb_fsm.h"

tb_fsm::tb_fsm(sc_module_name name) {
	SC_THREAD(test);
}

void tb_fsm::test() {
	counter_cars_mainstreet.write(5);
	counter_cars_sidestreet.write(3);
	cout << "5 cars on main and 3 on side: " << endl;
	cout << "trafficlight_mainstreet: " << trafficlight_mainstreet.read() << endl;
	cout << "trafficlight_sidestreet: " << trafficlight_sidestreet.read() << endl;
	wait(31, SC_SEC);
	cout << "wait for 31 sec: " << endl;
	cout << "trafficlight_mainstreet: " << trafficlight_mainstreet.read() << endl;
	cout << "trafficlight_sidestreet: " << trafficlight_sidestreet.read() << endl;
	wait(2, SC_SEC);
	counter_cars_mainstreet.write(2);
	counter_cars_sidestreet.write(7);
	counter_tram.write(2);
	cout << "2 cars on main and 7 on side and 2 trams: " << endl;
	cout << "trafficlight_mainstreet: " << trafficlight_mainstreet.read() << endl;
	cout << "trafficlight_sidestreet: " << trafficlight_sidestreet.read() << endl;
	wait(31, SC_SEC);
	cout << "wait for 31 sec: " << endl;
	cout << "trafficlight_mainstreet: " << trafficlight_mainstreet.read() << endl;
	cout << "trafficlight_sidestreet: " << trafficlight_sidestreet.read() << endl;
	counter_tram.write(0);
	cout << "2 cars on main and 7 on side and 0 trams: " << endl;
	cout << "trafficlight_mainstreet: " << trafficlight_mainstreet.read() << endl;
	cout << "trafficlight_sidestreet: " << trafficlight_sidestreet.read() << endl;
	wait(6, SC_SEC);
}



