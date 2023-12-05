extends Building

@onready var timer = $Timer
@export var GOAL: Node2D
@export var rotate_speed_deg: float = 30

var target: Node2D
var _lock_on_target := false:
	set(val):
		if val && !_lock_on_target && timer.is_stopped():
			# Shoot directly when we just lock on target, and we're not on cooldown
			shoot()
		_lock_on_target = val

const BULLET = preload("res://scenes/Bullet.tscn")

# Custom Canon behavior
func _ready():
	super()


func _physics_process(delta):
	var closer_body: Node2D = null
	var _dist: float = 999999999999

	# TODO: should be body closer to objective
	for body in $Area2D.get_overlapping_bodies():
		if body is Enemy:
			var d = body.global_position.distance_to(self.global_position)
			if d < _dist:
				closer_body = body
				_dist = d
	
	target = closer_body

	if target != null:
		var angle_left = $Gun.get_angle_to(target.global_position) # Why global?
		var max_speed = deg_to_rad(rotate_speed_deg) * delta
		angle_left = clampf(angle_left, -max_speed, max_speed)
		$Gun.rotate(angle_left)
		_lock_on_target = abs(angle_left) < deg_to_rad(rotate_speed_deg) * delta
	else:
		timer.stop()

func _on_timer_timeout():
	if _lock_on_target:
		shoot()

# Is called when we just locked on target and timer is stopped,
# or when timer times out and we're already locked on target
func shoot():
	if target != null and self.is_physics_processing():
		if timer.is_stopped():
			timer.start()
		var bullet = BULLET.instantiate()
		bullet.position = $Gun.position
		bullet.rotation = $Gun.rotation
		self.add_child(bullet)

