extends Node2D

enum State {
	IDLE,
	MOVING
	# Could create more state here, like attacking, broken maybe?
}

signal state_changed(old: State, new: State)
var state: State:
	get:
		return state
	set(new_state):
		state_changed.emit(state, new_state)
		state = new_state

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.MOVING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion and state == State.MOVING:
		var snap := 16*3
		var offset := 16 + 16/2
		self.position = Vector2(int(event.position.x / snap) * snap + offset, int(event.position.y / snap) * snap - offset)
	elif event is InputEventMouseButton and event.is_pressed():
		if state == State.MOVING:
			state = State.IDLE
		elif state == State.IDLE:
			state = State.MOVING

func _on_state_changed(old, new):
	if new == State.MOVING:
		$Sprite2D.set_modulate(Color(1, 1, 1, 0.5))
	elif new == State.IDLE:
		$Sprite2D.set_modulate(Color(1, 1, 1, 1))
