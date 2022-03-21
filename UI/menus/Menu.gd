extends Control


export(String, FILE, "*.tscn") var level_path
export(String, FILE, "*.tscn") var options_menu_path

func _ready():
	$Vbox/Start.grab_focus()


func transition_to(_next_scene: NodePath) -> void:
		
	# Here you can play an animation when you 'transition' to a new scene
	# example:
#	_anim_player.play("Fade")
#	yield(_anim_player, "animation_finished")

	# Changes the scene and prints error message
	if get_tree().change_scene(_next_scene) != OK:
		print("An unexpected error occured when trying to transition scenes")


# changes scene to the first level
func _on_Start_pressed() -> void:
	transition_to(level_path)


# adds the options_menu scene as a child
func _on_Options_pressed() -> void:
	var options_menu = load(options_menu_path).instance()
	get_tree().current_scene.add_child(options_menu)	

# closes the game
func _on_Quit_pressed() -> void:
	get_tree().quit()

