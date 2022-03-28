extends Control

onready var audio: AudioStreamPlayer = $AudioStreamPlayer
onready var buttons: VBoxContainer = $ButtonContainer/Panel/Buttons
onready var fade_in: ColorRect = $FadeIn
var scene_path_to_load

func _ready():
	$ButtonContainer/Panel/Buttons/Play.grab_focus()
	for button in buttons.get_children():
		if not button.scene_to_load: #if there is no "scene to load set"
			print("Button[%s] scene_to_load variable is not defined!" % button.name)
			continue
		button.connect("pressed", self, 
				"_on_Button_pressed", [button.scene_to_load])


func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	if get_tree().change_scene(scene_path_to_load) != OK:
		print("An unexpected error occured when trying to transition scenes")

