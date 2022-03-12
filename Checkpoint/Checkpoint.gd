extends Area2D

export (bool) var _is_active
export (bool) var _is_finish_line
export (NodePath) var _next_checkpoint

func _ready() -> void:
	pass


func _on_Checkpoint_body_entered(_body: Node) -> void:
	if _is_active:
		if _is_finish_line:
			Global.increment_lap_counter()
		
		_is_active = false
		get_node(_next_checkpoint).activate()


func activate() -> void:
	_is_active = true
