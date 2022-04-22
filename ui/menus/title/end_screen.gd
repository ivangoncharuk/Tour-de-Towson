extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_parameters(time, position):
	position = set_placement(position)
	$ColorRect/CenterContainer/VBoxContainer/SecondsLabel.text = str(int(time)) + " seconds"
	$ColorRect/CenterContainer/VBoxContainer/Label3.text= position
func set_placement(position):
	if position == 1:
		return "1st"
	elif position == 2:
		return "2nd"
	elif position == 3:
		return "3rd"
	else:
		return str(position) + "th"
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RetryButton_pressed():
	get_tree().get_root().get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
