extends Node2D

@onready var movable_enemy_spawner: Node2D = $MovableEnemySpawner
@onready var static_enemy_spawner: Node2D = $StaticEnemySpawner
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
var enable_static_enemy_spawner: bool = true
var enable_movable_enemy_spawner: bool = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.hide()

	if enable_movable_enemy_spawner:
		movable_enemy_spawner.process_mode = Node.PROCESS_MODE_PAUSABLE
	else:
		movable_enemy_spawner.process_mode = Node.PROCESS_MODE_DISABLED

	if enable_static_enemy_spawner:
		static_enemy_spawner.process_mode = Node.PROCESS_MODE_PAUSABLE
	else:
		static_enemy_spawner.process_mode = Node.PROCESS_MODE_DISABLED

func _on_ground_area_body_entered(body: Node2D) -> void:
	print("Enemy has hit to the ground")
	body.queue_free.call_deferred()
