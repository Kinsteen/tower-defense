class_name Building extends Node2D

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

signal state_changed(old: State, new: State)
var state: State:
	set(new_state):
		state_changed.emit(state, new_state)
		state = new_state

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.MOVING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not can_place.call(self):
		$Sprite2D.set_modulate(Color(1, .5, .5, 0.8))
	else:
		self._on_state_changed(state, state)

# This is triggered everywhere everytime?
func _input(event):
	if event is InputEventMouseMotion and state == State.MOVING:
		var snap := 16*3
		var offset := 16 + 16/2
		self.position = Vector2(
			int(event.position.x / snap) * snap + offset,
			int(event.position.y / snap) * snap
		)
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if state == State.MOVING and can_place.call(self):
				state = State.IDLE
				get_viewport().set_input_as_handled() # Stop propagating the event

func _on_state_changed(old, new):
	if new == State.MOVING:
		$Sprite2D.set_modulate(Color(1, 1, 1, 0.3))
	elif new == State.IDLE:
		$Sprite2D.set_modulate(Color(1, 1, 1, 1))

# This is only when clicking in the collision shape
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if state == State.IDLE and can_place.call(self): # TODO dirty, should remember when we're moving something?
				state = State.MOVING
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Something else...")
