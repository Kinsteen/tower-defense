extends Node

signal pause
signal unpause
signal started_signal(old, new)
signal wave_number_signal(new)
signal enemy_defeated_signal(new)
signal wave_finished

var started: bool = false:
	set(new):
		if started != new:
			started_signal.emit(started, new)
		started = new

var wave_number: int = 0:
	set(new):
		wave_number = new
		wave_number_signal.emit(new)

var enemy_defeated: int = 0:
	set(new):
		enemy_defeated = new
		if new != 0:
			enemy_defeated_signal.emit(enemy_defeated)

func quit():
	get_tree().quit()
