extends Area2D
var _collected = false setget set_collected, get_collected


func _on_Checkpoint_body_entered(body: KinematicBody2D):
	if(body is Player):
		_collected = true

func get_collected():
	return _collected
func set_collected(set: bool):
	_collected = set
