extends Control
export (NodePath) var player_path
var player = null

onready var _current_lap: Label = $Panel/VBoxContainer/LapContainer/CurrentLap
onready var _time: Label = $Panel/VBoxContainer/TimeContainer/CurrentTime

onready var v_label: Label = $Panel/VBoxContainer/Velocity/Label
onready var v_progress: ProgressBar = $Panel/VBoxContainer/Velocity/ProgressBar
onready var v_progress_label: Label = $Panel/VBoxContainer/Velocity/ProgressBar/Label

onready var a_label: Label = $Panel/VBoxContainer/Acceleration/Label
onready var a_progress: ProgressBar = $Panel/VBoxContainer/Acceleration/ProgressBar
onready var a_progress_label: Label = $Panel/VBoxContainer/Acceleration/ProgressBar/Label

func _ready() -> void:
	# if a path to a player exists, set the player to that path
	if player_path:
		player = get_node(player_path) as Player


func _process(_delta: float) -> void:
	if not player is Player:
		return
		
	_current_lap.text = "%1d" % Global._lap_counter
	_time.text = _format_time(player.get_current_time())

	# create a way to automate this: 
	v_label.text = "Velocity"
	v_progress.max_value = 550
	v_progress.value = player.velocity.length()
	v_progress_label.text = str("%1.0f / %d" % [player.velocity.length(), v_progress.max_value])

	a_label.text = "Acceleration"
	a_progress.value = player.acceleration.length()
	a_progress.max_value = 1000
	a_progress_label.text = str("%1.0f / %d" % [player.acceleration.length(), a_progress.max_value])
	
func _format_time(time: float) -> String:
#	var mils := fmod(time, 1) * 1000
	var secs := fmod(time, 60)
	var mins := fmod(time, 60 * 60) / 60
	return "%02d : %02d" % [mins, secs]
