extends CanvasLayer
var is_paused: bool = false setget set_is_paused


onready var pause_menu: Control = $PauseMenu
onready var player_hud: Control = $PlayerHUD
onready var control_panel: Control = $ControlPanel
onready var begin_timer: Control = $BeginTimer
onready var is_player_hud: bool = player_hud.visible
onready var is_control_panel: bool = control_panel.visible

func _ready():
	get_tree().paused = true
	begin_timer.visible = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		# self. refers to the setter -> setget set_is_paused
		self.is_paused = !is_paused
	
	# these input events are blocked by paused state
	elif not is_paused:
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
	
	# ui elements that were toggled by a key, will go back to their state
	if not is_paused:
		player_hud.visible = is_player_hud
		control_panel.visible = is_control_panel
	# hiding elements when game is paused
	else:
		control_panel.hide()
		player_hud.hide()

func _on_Resume_pressed():
	self.is_paused = false

func _on_Quit_pressed():
	get_tree().quit()
