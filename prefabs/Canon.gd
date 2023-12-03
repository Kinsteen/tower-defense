extends Building

@onready var timer = $Timer
var target: Node2D
@export var GOAL: Node2D

const BULLET = preload("res://scenes/Bullet.tscn")

# Custom Canon behavior
func _ready():
	super()
	timer.start()

func _physics_process(delta):
	var closer_body: Node2D = null
	var _dist: float = 999999999

	# TODO: should be body closer to objective
	for body in $Area2D.get_overlapping_bodies():
		if body is Enemy:
			var d = body.global_position.distance_to(self.global_position)
			if d < _dist:
				closer_body = body
				_dist = d
	
	target = closer_body

	if target != null:
		$Gun.look_at(target.global_position) # Why global?

func _on_body_entered(body):
	if body is Enemy and target == null:
		target = body

func _on_body_exited(body):
	if body == target:
		target = null


func _on_timer_timeout():
	if target != null:
		var bullet = BULLET.instantiate()
		bullet.position = $Gun.position
		bullet.rotation = $Gun.rotation
		self.add_child(bullet)
