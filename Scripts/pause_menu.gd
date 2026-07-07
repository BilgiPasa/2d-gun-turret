extends Control

signal resume # Resume signal for the main scene

@onready var resume_button: Button = $Panel/ResumeButton

func _on_visibility_changed() -> void:
	if visible:
		resume_button.grab_focus()

func _on_resume_button_pressed() -> void:
	resume.emit()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
