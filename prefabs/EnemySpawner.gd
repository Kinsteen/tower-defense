class_name EnemySpawner extends Sprite2D

@export var ENEMY_SCENE : PackedScene = null
@export var GOAL : Node2D = null
@onready var timer = $Timer as Timer

@export var wave_datas: Array[WaveData]

func _ready():
	assert(ENEMY_SCENE != null)
	assert(GOAL != null)
	Game.started_signal.connect(func(old, new):
		if new:
			timer.start(randf_range(wave_datas[Game.wave_number].minimum_spawn_delay, wave_datas[Game.wave_number].maximum_spawn_delay))
	)

	# TODO should not be here, maybe in Game?
	# should check if every spawner has met their requirement
	Game.enemy_defeated_signal.connect(func(new):
		if new >= wave_datas[Game.wave_number].number_enemies:
			Game.wave_finished.emit()
	)

	# TODO should not be here
	Game.wave_finished.connect(func():
		Game.enemy_defeated = 0
		if Game.wave_number + 1 < wave_datas.size():
			Game.wave_number += 1
		else:
			print("You won, no more waves :)")
	)

func _on_timer_timeout():
	timer.start(randf_range(wave_datas[Game.wave_number].minimum_spawn_delay, wave_datas[Game.wave_number].maximum_spawn_delay))
	var enemy_entity = ENEMY_SCENE.instantiate()
	
	enemy_entity.HP = 30
	enemy_entity.DAMAGE = 10
	enemy_entity.GOAL = GOAL
	
	add_child(enemy_entity)
