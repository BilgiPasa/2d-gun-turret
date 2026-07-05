class_name StaticEnemy
extends StaticBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free.call_deferred()
	queue_free.call_deferred()
