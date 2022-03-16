extends Control
signal bullet_fired
var is_paused: bool = false setget set_is_paused
onready var control_panel_visible: bool = get_parent().get_node("ControlPanel").visible

func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		control_panel_visible = !control_panel_visible


func set_is_paused(value: bool) -> void:
	
	is_paused = value
	# pauses the whole tree
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_pressed():
	self.is_paused = false



func _on_Quit_pressed():
	get_tree().quit()
