extends Control
export (NodePath) var player_path
var player = null

onready var vbox: VBoxContainer = $Panel/VBoxContainer

onready var _current_lap: Label = $Panel/VBoxContainer/LapContainer/CurrentLap
onready var _time: Label = $Panel/VBoxContainer/TimeContainer/CurrentTime

onready var _wheel_base: Label = $Panel/VBoxContainer/WheelBaseContainer/WheelBase


onready var _v_label: Label = $Panel/VBoxContainer/Velocity/Label
onready var _v_progress: ProgressBar = $Panel/VBoxContainer/Velocity/ProgressBar
onready var _v_progress_label: Label = $Panel/VBoxContainer/Velocity/ProgressBar/Label

onready var _a_label: Label = $Panel/VBoxContainer/Acceleration/Label
onready var _a_progress: ProgressBar = $Panel/VBoxContainer/Acceleration/ProgressBar
onready var _a_progress_label: Label = $Panel/VBoxContainer/Acceleration/ProgressBar/Label

func _ready() -> void:
	# if a path to a player exists, set the player to that path
	if player_path:
		player = get_node(player_path) as Player
		
	# vbox.add_child(_create_entry("name"))

func _create_entry(name: String = "label_name") -> HBoxContainer:
	var hbox := HBoxContainer.new()
	var label := Label.new()
	var data_label := Label.new()
	
	hbox.name = name
	label.text = name
	label.size_flags_horizontal = SIZE_EXPAND
	
	hbox.add_child(label)
	hbox.add_child(data_label)
	return hbox

func _process(_delta: float) -> void:
	if not player is Player:
		return
	
	### Lap Counter
	_current_lap.text = "%1d" % Global._lap_counter
	if player.has_method("get_current_time"):
		_time.text = _format_time(player.get_current_time())
	else:
		_time.text = "##:##:###"
	
	### Wheel Base
	_wheel_base.text = str(player.wheel_base)
	
	# create a way to automate this: 
	### Velocity
	_v_label.text = "Velocity"
	_v_progress.max_value = 550
	_v_progress.value = player.velocity.length()
	_v_progress_label.text = str("%1.0f / %d" % [player.velocity.length(), _v_progress.max_value])
	
	### Acceleration
	_a_label.text = "Acceleration"
	_a_progress.max_value = 1000
	_a_progress.value = player.acceleration.length()
	_a_progress_label.text = str("%1.0f / %d" % [player.acceleration.length(), _a_progress.max_value])

"""
Formats the float value of time into a readable string in this format:
	[mm:hh:sss]
"""
func _format_time(time: float) -> String:
	var mils := fmod(time, 1) * 1000
	var secs := fmod(time, 60)
	var mins := fmod(time, 60 * 60) / 60
	# %02d = two 0's as placeholders
	return "%02d : %02d : %03d" % [mins, secs, mils]
