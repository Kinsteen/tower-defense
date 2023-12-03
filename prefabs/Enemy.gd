extends CharacterBody2D

@export var HP : int = 30
@export var DAMAGE : int = 10
@export var GOAL : Node2D = null
@export var SPEED : int = 50

func _ready():
	assert(GOAL != null)

func _physics_process(delta):
	if GOAL:
		var target = GOAL.position
		var new_position = position.move_toward(target, SPEED)
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
	if body.has_method("take_damage") and body == GOAL:
		body.take_damage(DAMAGE)
		queue_free()
