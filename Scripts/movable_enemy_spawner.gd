extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_increaser_timer: Timer = $SpawnIncrTimer
const SPAWN_X_RANGE: int = 750
const SPEED_RANGE: int = 500
const MIN_SPAWN_TIME: float = 0.25
const MOVABLE_ENEMY_SCENE = preload("res://Scenes/movable_enemy.tscn")

func _ready() -> void:
	spawn_timer.wait_time = 0.5
	spawn_timer.autostart = true
	spawn_timer.start()
	spawn_increaser_timer.wait_time = 1
	spawn_increaser_timer.autostart = true
	spawn_increaser_timer.start()

func _on_spawn_timer_timeout() -> void:
	var new_movable_enemy = MOVABLE_ENEMY_SCENE.instantiate()
	new_movable_enemy.position = global_position + Vector2(randi_range(-SPAWN_X_RANGE, SPAWN_X_RANGE), 0)
	owner.add_child(new_movable_enemy)
	new_movable_enemy.linear_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * SPEED_RANGE

# On Spawn Increaser Timer Timeout
func _on_spawn_incr_timer_timeout() -> void:
	if spawn_timer.wait_time > MIN_SPAWN_TIME:
		spawn_timer.wait_time -= 0.01
