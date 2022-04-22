extends Area2D
class_name Checkpoint

export (bool) var _is_active
export (bool) var _is_finish_line
export (NodePath) var _next_checkpoint
signal placed

func _ready() -> void:
	pass


func _on_Checkpoint_body_entered(body: Node) -> void:
	if body is Player && body.is_human:
		if not _is_active:
			return
		if _is_finish_line:
			body.current_lap += 1
			if(body.current_lap == body.num_lap_to_finish):
				emit_signal("placed")

			Global.increment_lap_counter()
		_is_active = false
		get_node(_next_checkpoint).activate()
	elif body is Player:
		if _is_finish_line:
			body.current_lap += 1
			if(body.current_lap == body.num_lap_to_finish):
				emit_signal("placed")
		


func activate() -> void:
	_is_active = true

