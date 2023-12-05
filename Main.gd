extends Node

@onready var ingame_menu = $CanvasLayer/IngameMenu as Control
@onready var play_menu = $CanvasLayer/PlayMenu as Control
@onready var game_scene = $GameScene as Node2D
@onready var overlay = $CanvasLayer/Overlay

# TODO maybe use a list of screens on top of each other?
# easier pop/push

func _ready():
	Game.pause.connect(_pause)
	Game.unpause.connect(_unpause)
	Game.pause.emit()

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		if ingame_menu.visible:
			Game.pause.emit()
		else:
			Game.unpause.emit()
	
func _pause():
	ingame_menu.hide()
	play_menu.show()
	overlay.show()
	get_tree().paused = true

func _unpause():
	ingame_menu.show()
	play_menu.hide()
	overlay.hide()
	get_tree().paused = false

func _on_play_button_pressed():
	Game.unpause.emit()
	
	if not Game.started:
		Game.started = true
