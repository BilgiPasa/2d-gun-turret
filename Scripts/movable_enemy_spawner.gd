extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
const SPAWN_X_RANGE: int = 800
const SPEED_RANGE: int = 600
const SPAWN_TIME: float = 0.2
const MOVABLE_ENEMY_SCENE = preload("res://Scenes/movable_enemy.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	spawn_timer.wait_time = SPAWN_TIME
	spawn_timer.autostart = true
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var new_movable_enemy = MOVABLE_ENEMY_SCENE.instantiate()
	new_movable_enemy.position = global_position + Vector2(randi_range(-SPAWN_X_RANGE, SPAWN_X_RANGE), 0)
	owner.add_child(new_movable_enemy)
	new_movable_enemy.linear_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * SPEED_RANGE
