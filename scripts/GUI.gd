extends CanvasLayer

func _on_button_pressed():
	GuiEvents.create_canon.emit()

