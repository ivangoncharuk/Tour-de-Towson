extends Node2D
onready var path = $Path2D
onready var path_follow = $Path2D/PathFollow2D
onready var countdown_timer = $HUD/CountdownTimer
onready var player = $Player
onready var ai_container = $AIContainer
onready var end_screen = $HUD/end_screen
onready var current_position = 0
func _ready():
	countdown_timer.set_active(true)
	set_movement_locked(true)

func get_path_direction(pos):
	var offset = path.curve.get_closest_offset(pos)
	path_follow.offset = offset
	return path_follow.transform.x


func _on_CountdownTimer_go():
	set_movement_locked(false)
	player.is_timer_on = true;


func set_movement_locked(value: bool):
	player.is_movement_locked = value
	for i in ai_container.get_children():
		i.is_movement_locked = value


func _on_Player_game_over(time):
	end_screen.visible = true;
	end_screen.set_parameters(time,current_position);
	player.is_human = false;
	pass # Replace with function body.




func _on_CP_placed():
	current_position += 1
	pass # Replace with function body.
