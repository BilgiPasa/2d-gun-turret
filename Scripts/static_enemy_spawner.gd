extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_increaser_timer: Timer = $SpawnIncrTimer
const SPAWN_RADIUS: int = 750
const STATIC_ENEMY_SCENE = preload("res://Scenes/static_enemy.tscn")

func _ready() -> void:
	spawn_timer.wait_time = 0.5
	spawn_timer.autostart = true
	spawn_timer.start()
	spawn_increaser_timer.wait_time = 2
	spawn_increaser_timer.autostart = true
	spawn_increaser_timer.start()

func _on_spawn_timer_timeout() -> void:
	var new_static_enemy = STATIC_ENEMY_SCENE.instantiate()
	new_static_enemy.position = global_position + Vector2(randf_range(-SPAWN_RADIUS, SPAWN_RADIUS), randi_range(-SPAWN_RADIUS, SPAWN_RADIUS))
	owner.add_child(new_static_enemy)

func _on_spawn_incr_timer_timeout() -> void:
	if spawn_timer.wait_time > 0.25:
		spawn_timer.wait_time -= 0.01
