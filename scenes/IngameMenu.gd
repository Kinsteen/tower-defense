extends Control

@onready var wave_label = $MarginContainer/HBoxContainer2/WaveLabel

func _ready():
	Game.wave_number_signal.connect(_wave_signal)

func _on_button_pressed():
	GuiEvents.create_canon.emit()

func _wave_signal(old: int, new: int):
	wave_label.text = "Wave " + str(new)
