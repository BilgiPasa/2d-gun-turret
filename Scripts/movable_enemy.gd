class_name MovableEnemy
extends RigidBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY

func _on_body_entered(body: Node) -> void:
	if body is not GunTurret:
		body.queue_free.call_deferred()
		queue_free.call_deferred()
