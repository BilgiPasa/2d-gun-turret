class_name MovableEnemy
extends RigidBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_body_entered(body: Node) -> void:
	body.queue_free.call_deferred()
	queue_free.call_deferred()
