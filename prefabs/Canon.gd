extends Building

const BULLET = preload("res://prefabs/Bullet.tscn")

@onready var timer = $Timer as Timer
@export var GOAL: Node2D
@export var rotate_speed_deg: float = 30

# We're constantly updating 'next_target' with the closest target we have.
# We shoot at 'target', and after we shoot, we update 'target' to 'next_target'
# That way, we can't change target until we've taken a shot
var target: Node2D
var next_target: Node2D

var _lock_on_target := false:
	set(val):
		if val && !_lock_on_target && timer.is_stopped():
			# Shoot directly when we just lock on target, and we're not on cooldown
			shoot()
		_lock_on_target = val

func _process(delta):
	$BuildingHealth/ProgressBar.value = timer.time_left * 100
	$BuildingHealth/ProgressBar.max_value = timer.wait_time * 100

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
	
	next_target = closer_body
	
	if target == null and next_target != null and timer.is_stopped():
		target = next_target

	if target != null:
		if timer.is_stopped():
			timer.start()
		var angle_left = $Gun.get_angle_to(target.global_position) # Why global?
		var max_speed = deg_to_rad(rotate_speed_deg) * delta
		angle_left = clampf(angle_left, -max_speed, max_speed)
		$Gun.rotate(angle_left)
		_lock_on_target = abs(angle_left) < max_speed

func _on_timer_timeout():
	if _lock_on_target:
		shoot()
	target = next_target

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

