extends StaticBody2D

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var target_find_area: Area2D = $TargetFindArea
@onready var shoot_timer: Timer = $ShootTimer
const BULLET_SCENE = preload("res://Scenes/bullet.tscn")
var default_bullet_x_vel = 2000
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_shoot: bool = true
var shoot_vector: Vector2
var targets: Array[Node2D]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func give_closest_target() -> Node2D:
	var closest_node: Node2D = null
	targets = target_find_area.get_overlapping_bodies()

	if len(targets) > 0:
		closest_node = targets[0]

		for i in targets:
			if how_far_is_target(closest_node.position) < how_far_is_target(i.position):
				closest_node = i

	return closest_node

func how_far_is_target(target_pos: Vector2) -> float:
	return sqrt(pow(target_pos.x - gun_sprite.global_position.x, 2) + pow(target_pos.y - gun_sprite.global_position.y, 2))

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
