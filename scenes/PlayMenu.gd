extends Control

signal play_button_pressed
signal quit_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	play_button_pressed.emit()


func _on_quit_button_pressed():
	Game.quit()