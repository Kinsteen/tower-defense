class_name BuildingPopup extends Control

var parent: Building

const BUILDING_POPUP = preload("res://scenes/BuildingPopup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(parent != null)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if not self.has_point(event.position):
			self.queue_free()

func has_point(point: Vector2) -> bool:
	# Why can't I use self?
	return Rect2($VBoxContainer.global_position, $VBoxContainer.size).has_point(point)

func _on_pickup_pressed():
	parent.state = Building.State.MOVING
	self.queue_free()

func _on_delete_pressed():
	parent.queue_free()
	self.queue_free()

static func create_popup(building: Building):
	if building.get_tree().get_nodes_in_group("building_popup").size() == 0:
		var popup := BUILDING_POPUP.instantiate()
		popup.parent = building
		popup.position = building.get_global_mouse_position() - building.position
		building.add_child(popup)
