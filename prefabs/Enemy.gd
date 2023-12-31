class_name Enemy extends CharacterBody2D

@export var HP : int = 30
@export var DAMAGE : int = 10
@export var GOAL : Node2D = null
@export var PATH : Array[Vector2]
@export var SPEED : int = 50

var current_target : Vector2

func _ready():
	assert(GOAL != null)
	assert(PATH != null && PATH.size() > 0)
	current_target = PATH.pop_front()

func _physics_process(delta):
	if GOAL:
		if global_position.distance_to(current_target) < 2:
			current_target = PATH.pop_front()
		var target = current_target
		velocity = global_position.direction_to(target) * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func take_damage(amount):
	HP -= amount
	if HP <= 0:
		Game.enemy_defeated += 1
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage") and body == GOAL:
		body.take_damage(DAMAGE)
		queue_free()


func _on_area_2d_area_entered(area):
	if area is Bullet:
		self.take_damage(10)
		area.queue_free()
