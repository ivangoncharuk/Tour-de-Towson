extends Control

export (NodePath) var player_path # Drag in the thing you want to control
var SettingSlider = preload("res://ui/control_panel/SettingSlider.tscn")
var player = null


var car_settings := [
	'traction_fast',
	'traction_slow',
	'engine_power',
	'braking',
	'friction',
	'drag',
	'slip_speed',
	'steering_angle',
	]


var ranges := {
	'traction_fast': 	[0, 1.0, 0.01],
	'traction_slow': 	[0, 1.0, 0.01],
	'engine_power': 	[500, 2000, 10],
	'braking': 			[-1000, -100, 10],
	'friction': 		[-1.0, -0.01, 0.01],
	'drag': 			[-0.1, 0, 0.001],
	'slip_speed': 		[100, 1500, 10],
	'steering_angle': 	[0, 45, 1], 	}


func _ready() -> void:
	# if there is no player_path
	if not player_path:
		return

	player = get_node(player_path)
	for setting in car_settings:
		var ss = SettingSlider.instance()
		var slider = ss.get_node("Slider")
		ss.name = setting
		$Panel/VBoxContainer.add_child(ss)
		slider.min_value = ranges[setting][0]
		slider.max_value = ranges[setting][1]
		slider.step 	 = ranges[setting][2]
		
		slider.value = player.get(setting)
		ss.get_node("Label").text = setting
		ss.get_node("Value").text = str(player.get(setting))
		
		slider.connect("value_changed", self, "_on_Value_changed", [ss])


func _on_Value_changed(value, node) -> void:
	player.set(node.name, value)
	node.get_node("Value").text = str(value)


func _process(_delta) -> void:
	if not player:
		return
		
	# make this pattern for more values
	var v_label: Label = $Panel/VBoxContainer/Velocity/Label
	var v_progress: ProgressBar = $Panel/VBoxContainer/Velocity/ProgressBar
	var v_progress_label: Label = $Panel/VBoxContainer/Velocity/ProgressBar/Label
	v_label.text = "Velocity"
	v_progress.max_value = 550
	v_progress.value = player.velocity.length()
	v_progress_label.text = str("%1.0f / %d" % [player.velocity.length(), v_progress.max_value])

	var a_label: Label = $Panel/VBoxContainer/Acceleration/Label
	var a_progress: ProgressBar = $Panel/VBoxContainer/Acceleration/ProgressBar
	var a_progress_label: Label = $Panel/VBoxContainer/Acceleration/ProgressBar/Label
	a_label.text = "Acceleration"
	a_progress.value = player.acceleration.length()
	a_progress.max_value = 1000
	a_progress_label.text = str("%1.0f / %d" % [player.acceleration.length(), a_progress.max_value])
	

func _on_DebugDraw_toggled(button_pressed: bool) -> void:
	if not player:
		return

	player.is_playerui_enabled = button_pressed
