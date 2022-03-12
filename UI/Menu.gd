extends Control

func _ready():
	$Vbox/Start.grab_focus()

func _on_Start_pressed() -> void:
	get_tree().change_scene("res://Levels/Level.tscn")

func _on_Options_pressed():
	var options_menu = load("res://UI/OptionsMenu.tscn").instance()
	get_tree().current_scene.add_child(options_menu)

func _on_Quit_pressed():
	get_tree().quit()
