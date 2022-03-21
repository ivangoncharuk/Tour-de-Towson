extends Control
export (NodePath) var player_path
var player = null

onready var _current_lap: Label = $Panel/VBoxContainer/LapContainer/CurrentLap
onready var _time: Label = $Panel/VBoxContainer/TimeContainer/CurrentTime

func _ready():
	# if a path to a player exists, set the player to that path
	if player_path:
		player = get_node(player_path) as Player

func _input(event):
	if event.is_action_pressed("toggle_hud"):
		visible = !visible

func _process(_delta: float):
	if player is Player:
		_current_lap.text = "%1d" % Global._lap_counter
		_time.text = _format_time(player.get_current_time())
		

func _format_time(time: float) -> String:
#	var mils := fmod(time, 1) * 1000
	var secs := fmod(time, 60)
	var mins := fmod(time, 60 * 60) / 60
	return "%02d : %02d" % [mins, secs]
