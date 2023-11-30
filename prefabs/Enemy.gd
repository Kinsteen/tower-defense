extends CharacterBody2D

@export var HP : int = 30
@export var DAMAGE : int = 10
@export var goal : Node2D = null

func _ready():
	assert(goal != null)

func _physics_process(delta):
	if goal:
		var target = goal.position
		var new_position = position.move_toward(target, 500)
		velocity = new_position - position
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func take_damage(amount):
	HP -= amount
	if HP <= 0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage") and body == goal:
		body.take_damage(DAMAGE)
		queue_free()
