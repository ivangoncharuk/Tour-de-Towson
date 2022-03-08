extends Control

export (NodePath) var player_path # Drag in the thing you want to control
var SettingSlider = preload("res://ControlPanel/SettingSlider.tscn")
var player = null


var car_settings = [
	'traction_fast',
	'traction_slow',
	'engine_power',
	'braking',
	'friction',
	'drag',
	'slip_speed',
	'steering_angle',
	'max_stamina',
	]


var ranges = {
	'traction_fast': 	[0, 1.0, 0.01],
	'traction_slow': 	[0, 1.0, 0.01],
	'engine_power': 	[500, 2000, 10],
	'braking': 			[-1000, -100, 10],
	'friction': 		[-1.0, -0.01, 0.01],
	'drag': 			[-0.1, 0, 0.001],
	'slip_speed': 		[100, 1500, 10],
	'steering_angle': 	[0, 45, 1],
	'max_stamina':		[0, 400, 1]}


func _ready():
	if player_path:
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


func _on_Value_changed(value, node):
	player.set(node.name, value)
	node.get_node("Value").text = str(value)


func _input(event):
	# Pressing tab hides the panel
	if event.is_action_pressed("ui_focus_next"):
		visible = !visible


func _process(_delta):
	if player:
		$Panel/VBoxContainer/Speedometer/Speed.text = "%3.1f" % player.velocity.length()