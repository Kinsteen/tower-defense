extends Sprite2D

@export var ENEMY_SCENE : PackedScene = null
@export var GOAL : Node2D = null

func _ready():
	assert(ENEMY_SCENE != null)
	assert(GOAL != null)
	$Timer.start(2)
	
func _on_timer_timeout():
	var enemy_entity = ENEMY_SCENE.instantiate()
	
	enemy_entity.HP = 30
	enemy_entity.DAMAGE = 10
	enemy_entity.GOAL = GOAL
	
	add_child(enemy_entity)
