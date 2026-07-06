extends RigidBody2D

@onready var lifespan_timer: Timer = $LifespanTimer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	z_index = -1
	lifespan_timer.wait_time = 5
	lifespan_timer.start()

func _on_lifespan_timer_timeout() -> void:
	queue_free.call_deferred()
