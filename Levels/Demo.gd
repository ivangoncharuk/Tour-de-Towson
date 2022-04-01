extends Node2D
onready var path = $Path2D
onready var path_follow = $Path2D/PathFollow2D
onready var countdown_timer = $HUD/CountdownTimer
onready var player = $Player
onready var ai_container = $AIContainer
func _ready():
	countdown_timer.set_active(true)
	set_movement_locked(true)

func get_path_direction(pos):
	var offset = path.curve.get_closest_offset(pos)
	path_follow.offset = offset
	return path_follow.transform.x

func _on_CountdownTimer_go():
	set_movement_locked(false)
	
func set_movement_locked(value: bool):
	player.is_movement_locked = value
	for i in ai_container.get_children():
		i.is_movement_locked = value
