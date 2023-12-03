extends CanvasLayer

var popup := preload("res://scenes/BuildingPopup.tscn")

func _ready():
	GuiEvents.show_building_popup.connect(_show_building_popup)

func _on_button_pressed():
	GuiEvents.create_canon.emit()

func _show_building_popup(building: Node2D, mouse_position: Vector2):
	if get_tree().get_nodes_in_group("building_popup").size() == 0:
		var popup_inst := popup.instantiate()
		popup_inst.parent = building
		popup_inst.global_position = mouse_position - building.position
		$Control.add_child(popup_inst)
