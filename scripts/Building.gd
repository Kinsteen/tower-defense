class_name Building extends Node2D

const BUILDING_POPUP = preload("res://scenes/gui/BuildingPopup.tscn")

enum State {
	IDLE,
	MOVING
	# Could create more state here, like attacking, broken maybe?
}

# This is necessary because the object doesn't have the context of other nodes
# This way, the GameScene can change this and add more logic. It avoids
# bottom -> up dependency, making the code reusable more easily
var can_place: Callable = func (this: Building):
	return true

# Could be used by children classes, with self.state_changed.connect(f)
signal state_changed(old: State, new: State)
var state: State:
	set(new_state):
		if state != new_state:
			state_changed.emit(state, new_state)
			self._on_state_changed(state, new_state)
		state = new_state

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.MOVING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.MOVING:
		self.set_modulate(Color(1, 1, 1, 0.3))
	elif state == State.IDLE:
		self.set_modulate(Color(1, 1, 1, 1))
	
	if can_place != null:
		if not can_place.call(self):
			self.set_modulate(Color(1, .5, .5, 0.8))

# This is triggered everywhere everytime?
func _input(event):
	if event is InputEventMouseMotion and state == State.MOVING:
		var snap := 16 * 3
		var offset := 8 * 3
		self.position = Vector2(
			int(get_global_mouse_position().x / snap) * snap + offset,
			int(get_global_mouse_position().y / snap) * snap
		)
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if state == State.MOVING and can_place.call(self):
				state = State.IDLE
		elif event.button_index == MOUSE_BUTTON_RIGHT and is_in_rect($Base, get_global_mouse_position()):
			if state == State.IDLE:
				BuildingPopup.create_popup(self)

func _on_state_changed(old, new):
	if new == State.MOVING:
		set_physics_process(false)
	elif new == State.IDLE:
		set_physics_process(true)

func is_in_rect(sprite: Sprite2D, position: Vector2):
	return sprite.get_rect().has_point(to_local(position) / Vector2(sprite.scale.x, sprite.scale.y))
