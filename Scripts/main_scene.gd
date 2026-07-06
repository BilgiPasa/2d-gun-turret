extends Node2D

@onready var movable_enemy_spawner: Node2D = $MovableEnemySpawner
@onready var static_enemy_spawner: Node2D = $StaticEnemySpawner
var enable_static_enemy_spawner: bool = true
var enable_movable_enemy_spawner: bool = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if enable_movable_enemy_spawner:
		movable_enemy_spawner.process_mode = Node.PROCESS_MODE_PAUSABLE
		movable_enemy_spawner.show()
	else:
		movable_enemy_spawner.process_mode = Node.PROCESS_MODE_DISABLED
		movable_enemy_spawner.hide()

	if enable_static_enemy_spawner:
		static_enemy_spawner.process_mode = Node.PROCESS_MODE_PAUSABLE
		static_enemy_spawner.show()
	else:
		static_enemy_spawner.process_mode = Node.PROCESS_MODE_DISABLED
		static_enemy_spawner.hide()

func _on_ground_area_body_entered(body: Node2D) -> void:
	print("Enemy has hit to the ground")
	body.queue_free.call_deferred()
