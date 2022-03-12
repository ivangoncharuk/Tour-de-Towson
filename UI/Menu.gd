extends Control

func _ready():
	$Vbox/Start.grab_focus()

# changes scene to the first level
func _on_Start_pressed() -> void:
	get_tree().change_scene("res://Levels/Level.tscn")

# adds the options_menu scene as a child
func _on_Options_pressed():
	var options_menu = load("res://UI/OptionsMenu.tscn").instance()
	get_tree().current_scene.add_child(options_menu)	
	
# closes the game
func _on_Quit_pressed():
	get_tree().quit()
