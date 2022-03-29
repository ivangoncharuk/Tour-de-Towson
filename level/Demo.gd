extends Node2D
onready var path = $Path2D
onready var path_follow = $Path2D/PathFollow2D
onready var countdown_timer = $HUD/CountdownTimer
onready var player = $Player

func _ready():
	countdown_timer.set_active(true)
	player.is_movement_locked = true

func get_path_direction(pos):
	var offset = path.curve.get_closest_offset(pos)
	path_follow.offset = offset
	return path_follow.transform.x

func _on_CountdownTimer_go():
	player.is_movement_locked = false
