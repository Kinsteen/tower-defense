extends Node

signal pause
signal unpause
signal started_signal(old, new)
signal wave_number_signal(old, new)

var started: bool = false:
	set(new):
		if started != new:
			started_signal.emit(started, new)
		started = new

var wave_number: int = 0:
	set(new):
		if wave_number != new:
			wave_number_signal.emit(started, new)
		wave_number = new

func quit():
	get_tree().quit()
