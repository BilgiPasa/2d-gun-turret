extends RigidBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_lifespan_timer_timeout() -> void:
	queue_free.call_deferred()
