extends Control

export (NodePath) var player_path

var player = null

func _ready():
	# if a path to a player exists, set the player to that path
	if player_path:
		player = get_node(player_path)

func _input(_event):
	pass
	# Pressing tab hides the panel
#	if event.is_action_pressed("ui_focus_next"):
#		visible = !visible

func _process(_delta):
	if player:
		$Panel/VBoxContainer/Speedometer/Stamina.text = "%3.1f" % player.stamina
#		$Panel/VBoxContainer/LapCounter/LapsCompleted.text = "%3.1f" % player.
