extends Node2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_ground_area_body_entered(body: Node2D) -> void:
	print("Enemy has entered to the ground")
	body.queue_free.call_deferred()
