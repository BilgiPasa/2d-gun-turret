extends StaticBody2D

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var shoot_timer: Timer = $ShootTimer
@onready var target_find_area: Area2D = $TargetFindArea
const SHOOT_TIMER_WAIT_TIME: float = 0.2
const BULLET_MIN_REACH_TIME: float = 0.5
const BULLET_SCENE = preload("res://Scenes/bullet.tscn")
var bullet_default_lin_vel_x = 2000
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_shoot: bool = true
var shoot_vector: Vector2
var targets: Array[Node2D]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	shoot_timer.wait_time = SHOOT_TIMER_WAIT_TIME

func give_closest_target() -> Node2D:
	var closest_node: Node2D = null
	targets = target_find_area.get_overlapping_bodies()

	if len(targets) > 0:
		closest_node = targets[0]

		for i in range(1, len(targets)):
			if how_far(closest_node.global_position) < how_far(targets[i].global_position):
				closest_node = targets[i]

	return closest_node

func how_far(target_global_position: Vector2) -> float:
	return sqrt(pow(target_global_position.x - gun_sprite.global_position.x, 2) + pow(target_global_position.y - gun_sprite.global_position.y, 2))

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
