extends StaticBody2D

# * Note: Godot's 2D Y axis increases as you go down and decreases as you go up.

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var can_shoot_timer: Timer = $CanShootTimer
@onready var target_find_area: Area2D = $TargetFindArea
@onready var mouse_position_node: Node2D = $MousePositionNode
const SHOOT_TIMER_WAIT_TIME: float = 0.2
const BULLET_SCENE = preload("res://Scenes/bullet.tscn")
var gravity_amount: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_shoot: bool = true
var targets: Array[Node2D]

# Shoot Bullet Calculation Variables
const BULLET_DEFAULT_LIN_VEL_X: float = 2000
const BULLET_MIN_REACH_TIME: float = 0.4
var t: float
var target_relative_position: Vector2
var shoot_vector: Vector2

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	can_shoot_timer.wait_time = SHOOT_TIMER_WAIT_TIME

func _physics_process(delta: float) -> void:
	attack_mouse(delta)

func attack_closest_target(physics_delta: float) -> void:
	if target_find_area.has_overlapping_bodies() && can_shoot:
		can_shoot = false
		shoot_bullet_to(give_closest_target(), physics_delta)
		can_shoot_timer.start()

func attack_mouse(physics_delta: float) -> void:
	mouse_position_node.global_position = get_global_mouse_position()

	if can_shoot:
		can_shoot = false
		shoot_bullet_to(mouse_position_node, physics_delta)
		can_shoot_timer.start()

func shoot_bullet_to(target: Node2D, physics_delta: float) -> void:
	var new_bullet = BULLET_SCENE.instantiate() # Make a new bullet
	target_relative_position = Vector2(target.global_position.x - gun_sprite.global_position.x, target.global_position.y - gun_sprite.global_position.y) # Find the position of the target relative to the gun
	t = abs(target_relative_position.x) / BULLET_DEFAULT_LIN_VEL_X # Calculate reach time based on default X speed

	if t >= BULLET_MIN_REACH_TIME:
		# Assign X speed
		if target_relative_position.x > 0:
			shoot_vector.x = BULLET_DEFAULT_LIN_VEL_X
		else:
			shoot_vector.x = -BULLET_DEFAULT_LIN_VEL_X
	else: # If reach time is too small
		t = BULLET_MIN_REACH_TIME # Set the reach time
		shoot_vector.x = target_relative_position.x / t # Calculate X speed

	if target is MovableEnemy:
		pass # TODO: Finish here
	else:
		# At the line below, I used (physics_delta * 4) to hit the target better because if I don't add it, it might miss the target by a small distance.
		shoot_vector.y = (target_relative_position.y / t) - (gravity_amount * (t + (physics_delta * 4)) / 2) # Calculate Y speed

	gun_sprite.look_at(shoot_vector) # Gun sprite looks at the target
	new_bullet.position = gun_sprite.global_position # Initialize the position of the bullet
	owner.add_child(new_bullet) # Add the bullet to the scene
	new_bullet.linear_velocity = shoot_vector # Add speed to the bullet

func give_closest_target() -> Node2D:
	var closest_node: Node2D = null
	targets = target_find_area.get_overlapping_bodies()

	if len(targets) > 0:
		closest_node = targets[0]

		for i in range(1, len(targets)):
			if how_far(closest_node.global_position) < how_far(targets[i].global_position):
				closest_node = targets[i]

	return closest_node

# Calculate how far is the target from the gun
func how_far(target_global_position: Vector2) -> float:
	target_relative_position = Vector2(target_global_position.x - gun_sprite.global_position.x, target_global_position.y - gun_sprite.global_position.y)
	return sqrt(pow(target_relative_position.x, 2) + pow(target_relative_position.y, 2))

func _on_can_shoot_timer_timeout() -> void:
	can_shoot_timer.stop()
	can_shoot = true
