extends Control


onready var scene_to_load = $VBoxContainer/Button.scene_to_load

func _on_Button_pressed():
	if get_tree().change_scene(scene_to_load) != OK:
		print("OptionsMenu: error when changing schenes")
