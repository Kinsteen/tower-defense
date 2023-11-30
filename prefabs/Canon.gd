extends Node2D

enum State {
	IDLE,
	MOVING
	# Could create more state here, like attacking, broken maybe?
}

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
	pass

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
		if state == State.MOVING:
			state = State.IDLE
			get_viewport().set_input_as_handled() # Stop propagating the event

func _on_state_changed(old, new):
	if new == State.MOVING:
		$Area2D/Sprite2D.set_modulate(Color(1, 1, 1, 0.3))
	elif new == State.IDLE:
		$Area2D/Sprite2D.set_modulate(Color(1, 1, 1, 1))

# This is only when clicking in the collision shape
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if state == State.IDLE:
			state = State.MOVING
