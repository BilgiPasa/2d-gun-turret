class_name MovableEnemy
extends RigidBody2D

@onready var retarget_timer: Timer = $RetargetTimer
var targeted: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	retarget_timer.wait_time = 0.5

func _physics_process(_delta: float) -> void:
	if position.y > 300:
		queue_free.call_deferred()

func _on_body_entered(body: Node) -> void:
	body.queue_free.call_deferred()
	queue_free.call_deferred()

func _on_retarget_timer_timeout() -> void:
	retarget_timer.stop()
	targeted = false
