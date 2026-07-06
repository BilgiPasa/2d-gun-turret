extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
const SPAWN_RADIUS: int = 750
const STATIC_ENEMY_SCENE = preload("res://Scenes/static_enemy.tscn")

func _ready() -> void:
	spawn_timer.wait_time = 0.5
	spawn_timer.autostart = true
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var new_static_enemy = STATIC_ENEMY_SCENE.instantiate()
	new_static_enemy.position = global_position + Vector2(randi_range(-SPAWN_RADIUS, SPAWN_RADIUS), randi_range(-SPAWN_RADIUS, SPAWN_RADIUS))
	owner.add_child(new_static_enemy)
