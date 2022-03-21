extends Node

var is_paused: bool = false setget set_is_paused


onready var pause_menu: Control = $CanvasLayer/PauseMenu
onready var player_hud: Control = $CanvasLayer/PlayerHUD
onready var control_panel: Control = $CanvasLayer/ControlPanel

onready var is_player_hud: bool = player_hud.visible
onready var is_control_panel: bool = control_panel.visible


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		if not is_paused:
			player_hud.visible = is_player_hud
			control_panel.visible = is_control_panel
		else:
			control_panel.hide()
			player_hud.hide()
	elif not is_paused:
		# cannot toggle control_panel & player_hud when is_paused	
		if event.is_action_pressed("toggle_player_hud"):
			player_hud.visible = !player_hud.visible
			is_player_hud = player_hud.visible
		elif event.is_action_pressed("toggle_control_panel"):
			control_panel.visible = !control_panel.visible
			is_control_panel = control_panel.visible


func set_is_paused(value: bool) -> void:
	# pauses the whole tree
	get_tree().paused = value
	is_paused = value
	pause_menu.visible = is_paused

	

func _on_Resume_pressed():
	self.is_paused = false


func _on_Quit_pressed():
	get_tree().quit()
