extends Area2D
func _on_FinishLine_body_entered(body):
	if(body.name == "Car"):
		get_parent().get_node("Car").finish_line()
