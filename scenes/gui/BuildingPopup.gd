class_name BuildingPopup extends Control

@export var parent: Building

const BUILDING_POPUP = preload("res://scenes/gui/BuildingPopup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(parent != null)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if not self.has_point(get_global_mouse_position()):
			self.queue_free()

func has_point(point: Vector2) -> bool:
	return Rect2(self.global_position, self.size).has_point(point)

func _on_pickup_pressed():
	parent.state = Building.State.MOVING
	self.queue_free()

func _on_toggle_pressed():
	parent.set_physics_process(!parent.is_physics_processing())
	self.queue_free()

func _on_delete_pressed():
	parent.queue_free()
	self.queue_free()
