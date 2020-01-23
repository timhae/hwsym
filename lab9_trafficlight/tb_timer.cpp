#include "systemc.h"
#include "tb_timer.h"

void tb_timer :: test() {
	reset = false;
	cout << "before reset: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;
	wait(1, SC_SEC);
	reset = true;
	cout << "after reset: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;
	wait(1, SC_SEC);
	reset = false;
	wait(30, SC_SEC);
	cout << "after 30 sec: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;
	wait(30, SC_SEC);
	cout << "after 60 sec: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;
	wait(60, SC_SEC);
	cout << "after 120 sec: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;
	wait(1, SC_SEC);
	cout << "after 121 sec: " << endl;
	cout << "timer_30sec: " << timer_30sec.read() << endl;
	cout << "timer_60sec: " << timer_60sec.read() << endl;
	cout << "timer_120sec: " << timer_120sec.read() << endl;

}



