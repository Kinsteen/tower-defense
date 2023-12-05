extends Sprite2D

@export var ENEMY_SCENE : PackedScene = null
@export var GOAL : Node2D = null
@export var wave_data: WaveData
@onready var timer = $Timer as Timer

func _ready():
	assert(ENEMY_SCENE != null)
	assert(GOAL != null)
	Game.started_signal.connect(func(old, new):
		if new:
			timer.start(randf_range(wave_data.minimum_spawn_delay, wave_data.maximum_spawn_delay))
	)
	
func _on_timer_timeout():
	timer.start(randf_range(wave_data.minimum_spawn_delay, wave_data.maximum_spawn_delay))
	var enemy_entity = ENEMY_SCENE.instantiate()
	
	enemy_entity.HP = 30
	enemy_entity.DAMAGE = 10
	enemy_entity.GOAL = GOAL
	
	add_child(enemy_entity)
