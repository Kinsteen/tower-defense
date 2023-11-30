extends CharacterBody2D

@export var HP = 30
@export var DAMAGE = 10

func _physics_process(delta):
	var target = Vector2(150, 500) #TODO update this to "Goal" node
	var new_position = position.move_toward(target, 50)
	velocity = new_position - position
	move_and_slide()

func take_damage(amount):
	HP -= amount
	if HP <= 0:
		queue_free()
