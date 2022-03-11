extends Control
export (NodePath) var player_path
var player = null

onready var _current_lap: Label = $Panel/VBoxContainer/LapCounter/CurrentLap
onready var _stamina: Label = $Panel/VBoxContainer/StaminaContainer/Stamina
onready var _time: Label = $Panel/VBoxContainer/TimeContainer/CurrentTime

func _ready():
	# if a path to a player exists, set the player to that path
	if player_path:
		player = get_node(player_path) as Player

func _input(_event):
	pass
#	if event.is_action_pressed("ui_focus_next"):
#		visible = !visible

func _process(_delta):
	if player is Player:
		var formatting = "%1.1f"
		_current_lap.text = formatting % Global.get_lap_counter()
		_stamina.text = formatting % player.stamina
		_time.text = _format_time(player.get_current_time())

func _format_time(time: float) -> String:
	var mils := fmod(time, 1) * 1000
	var secs := fmod(time, 60)
	var mins := fmod(time, 60 * 60) / 60
	return "%02d : %02d : %03d" % [mins, secs, mils]
