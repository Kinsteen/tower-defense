extends Node2D

var canon := preload("res://prefabs/Canon.tscn")
const BUILDING_HEALTH = preload("res://scenes/gui/BuildingHealth.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GuiEvents.create_canon.connect(_create_canon)


func _can_place(building: Building):
	for node in get_tree().get_nodes_in_group("building"):
		if node != building and node.position == building.position:
			return false
	return true

func _create_canon():
	var canon_inst = canon.instantiate()
	canon_inst.can_place = _can_place
	canon_inst.position = get_global_mouse_position()
	canon_inst.add_child(BUILDING_HEALTH.instantiate())
	self.add_child(canon_inst)
