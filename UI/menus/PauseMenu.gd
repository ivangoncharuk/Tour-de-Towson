extends Control

var is_paused: bool = false setget set_is_paused

func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


func set_is_paused(value: bool) -> void:
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_pressed():
	self.is_paused = false


func _on_Quit_pressed():
	get_tree().quit()
