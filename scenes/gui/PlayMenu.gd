extends Control

signal play_button_pressed
signal quit_button_pressed

func _on_play_button_pressed():
	play_button_pressed.emit()


func _on_quit_button_pressed():
	Game.quit()
