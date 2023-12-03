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
	if can_place != null:
		if not can_place.call(self):
			$Sprite2D.set_modulate(Color(1, .5, .5, 0.8))
		else:
			self._on_state_changed(state, state)

# This is triggered everywhere everytime?
func _input(event):
	if event is InputEventMouseMotion and state == State.MOVING:
		var snap := 16 * 3
		var offset := 8 * 3
		self.position = Vector2(
			int(event.position.x / snap) * snap + offset,
			int(event.position.y / snap) * snap
		)
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if state == State.MOVING and can_place.call(self):
				state = State.IDLE
		elif event.button_index == MOUSE_BUTTON_RIGHT and is_in_rect($Sprite2D, event.position):
			if state == State.IDLE:
				GuiEvents.show_building_popup.emit(self, to_global(event.position))

func _on_state_changed(old, new):
	if new == State.MOVING:
		$Sprite2D.set_modulate(Color(1, 1, 1, 0.3))
	elif new == State.IDLE:
		$Sprite2D.set_modulate(Color(1, 1, 1, 1))

func is_in_rect(sprite: Sprite2D, position: Vector2):
	return sprite.get_rect().has_point(to_local(position) / Vector2(sprite.scale.x, sprite.scale.y))