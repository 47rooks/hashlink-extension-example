package;

import hlext.HLExt.Greetings;

class Main {
	static public function main() {
		trace('Result managed in C side / greeting: ' + Greetings.get_greeting());
	}
}
