extends RigidBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
