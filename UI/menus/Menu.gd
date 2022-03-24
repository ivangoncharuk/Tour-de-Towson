extends Control


export(String, FILE, "*.tscn") var start_button_path
export(String, FILE, "*.tscn") var options_button_path

onready var audio: AudioStreamPlayer = $AudioStreamPlayer
onready var tween: Tween = $Tween

func _ready():
	audio.volume_db
	pass
#	$Vbox/Start.grab_focus()



"""
Changes the scene with an animation
"""
func transition_to(_next_scene: NodePath) -> void:
		
	# Here you can play an animation when you 'transition' to a new scene
	# example:
#	_anim_player.play("Fade")
#	yield(_anim_player, "animation_finished")

	if get_tree().change_scene(_next_scene) != OK:
		print("An unexpected error occured when trying to transition scenes")


func _on_Start_pressed() -> void:
	transition_to(start_button_path)


func _on_Options_pressed() -> void:
	var options_menu = load(options_button_path).instance()
	get_tree().current_scene.add_child(options_menu)	


func _on_Quit_pressed() -> void:
	get_tree().quit()
