extends KinematicBody2D
class_name Player, "res://assets/class_icons/bike_icon.png"

### Movement Exports ###
var debug_draw := false
export (bool) var is_live_race = false
export (bool) var is_human = false setget set_is_human

export (int) var num_lap_to_finish = 3
export (float) var traction_fast = 0.1
export (float) var traction_slow = 0.7
export (int) var engine_power = 800
export (int) var braking = -450
export (float) var friction = -0.5
export (float) var drag = -0.001
export (int) var slip_speed = 400
export (int) var steering_angle = 5 # in degrees
export (int) var max_speed_reverse = 50

onready var wheel_base = abs($FrontWheel.position.x - $BackWheel.position.x)

var is_movement_locked: bool
var acceleration := Vector2.ZERO
var velocity := Vector2.ZERO
var steer_direction: float


var is_timer_on: bool = false
var _time: float = 0 setget set_current_time, get_current_time

### AI ###
export(float) var steer_force = 0.05
export(int) var look_ahead = 200
export(int) var num_rays = 8
var last_loc: Vector2
var rng = RandomNumberGenerator.new()
var ray_directions := []
var interest := []
var danger := []
var chosen_dir := Vector2.ZERO


func _ready() -> void:
	# setup code for the AI
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for index in num_rays:
		var angle = index * 2 * PI / num_rays
		ray_directions[index] = Vector2.RIGHT.rotated(angle)
	
	if not is_human:
		modulate = Color(randf(), randf(), randf(), 1.0)


func _physics_process(delta: float) -> void:
	_handle_debug()
	# Movement
	if is_movement_locked: return
	acceleration = Vector2.ZERO
	
	if not is_human:
		_is_stuck()
		_set_interest()
		_set_danger()
		chosen_dir = _choose_direction()
		var desired_velocity: Vector2 = chosen_dir.rotated(rotation) * engine_power
		velocity = velocity.linear_interpolate(desired_velocity, steer_force)
		self.rotation = velocity.angle()
	else:
		steer_direction = _get_turn_input() * deg2rad(steering_angle)
		self.rotation = _calculate_steering(delta)
		
	_process_timer(delta)
	_apply_friction()
	
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)


func _handle_debug():
	if debug_draw:
		$Label.visible = true
	else:
		$Label.visible = false
		return

	var label: Label = $Label
	var spacing := "_".repeat(10)
	var label_string = ""
	
	label.add_color_override("font_color", Color(0, 0, 0))
	label.set_rotation(-self.rotation)
	
	label_string =  "%s%s%s\n" % ["self.is_live_race", spacing, str(is_live_race)]
	label_string += "%s%s%s\n" % ["self.is_human", spacing, str(is_human)]
	label_string += "%s%s(%.2f, %.2f)\n" % ["self.acceleration", spacing, self.velocity.x, self.velocity.y]
	label_string += "%s%s(%.2f, %.2f)\n" % ["self.velocity", spacing, self.acceleration.x, self.acceleration.y]
	label_string += "%s%s%s\n" % ["self.steer_direction", spacing, str(steer_direction)]
	label_string += "%s%s%.2f\n" % ["self.rotation", spacing, rad2deg(self.rotation)]
	label_string += "%s%s%s\n" % ["self.is_human", spacing, str(is_human)]
	label_string += "%s%s%s" % ["is_timer_on", spacing, str(is_timer_on)]
	
	label.text = label_string	
	# AI information
	if is_human: return
	label.add_color_override("font_color", Color(255, 100, 0))
	label.text += "\n___AI INFORMATION___\n"
	label.text += "%s%s%.2f\n" % ["AI: steer_force", spacing, steer_force]
	label.text += "%s%s%d\n" % ["AI: look_ahead", spacing, look_ahead]
	label.text += "%s%s%s\n" % ["AI: num_rays", spacing, num_rays]
	label.text += "%s%s(%.2f, %.2f)\n" % ["AI: last_loc", spacing, last_loc.x, last_loc.y]
	label.text += "%s%s%s\n" % ["AI: ray_directions", spacing, str(ray_directions)]
	label.text += "%s%s%s\n" % ["AI: interest", spacing, str(interest)]
	label.text += "%s%s%s\n" % ["AI: danger", spacing, str(ray_directions)]
	label.text += "%s%s(%.2f, %.2f)\n" % ["AI: chosen_dir", spacing, chosen_dir.x, chosen_dir.y]



func _get_turn_input() -> int:
	var turn: int = 0
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1	
	
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	elif Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power / 10
	elif Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	return turn


func set_is_human(value: bool):
	is_human = value

# Set interest in each slot based on world direction
func _set_interest():
	if owner and owner.has_method("get_path_direction"):
		var path_direction = owner.get_path_direction(position)
		for i in num_rays:
			var d = ray_directions[i].rotated(rotation).dot(path_direction)
			# If no world path, use default interest
			interest[i] = max(0, d)
	else:
		_set_default_interest()

# Default to moving forward
func _set_default_interest():
	for i in num_rays:
		var d = ray_directions[i].rotated(rotation).dot(transform.x)
		interest[i] = max(0, d)

# Cast rays to find danger directions
func _set_danger():
	var space_state = get_world_2d().direct_space_state
	for i in num_rays:
		var result = space_state.intersect_ray(position,
			position + ray_directions[i].rotated(rotation) * look_ahead, [self])
		danger[i] = 1.0 if result else 0.0


func _choose_direction() -> Vector2:
	# Eliminate interest in slots with danger
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	# Choose direction based on remaining interest
	var direction = Vector2.ZERO
	for i in num_rays:
		direction += ray_directions[i] * interest[i]
	direction = direction.normalized()
	return direction


func _is_stuck(from: int = -50, to: int = 50) -> void:
	if get_position() != last_loc:
		last_loc = get_position()
	else:
		position.x += rng.randi_range(from, to)
		position.y += rng.randi_range(from, to)


func _apply_friction() -> void:
	# if velocity is less than 5, avoid velocity decreasing infinititly small by
	# setting it equal to (0, 0)
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force


func _calculate_steering(delta: float) -> float:
	var rear_wheel: Vector2 = position - transform.x * wheel_base/2.0
	var front_wheel: Vector2 = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading: Vector2 = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var dot = new_heading.dot(velocity.normalized())
	if dot > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	elif dot < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	return new_heading.angle()


func _process_timer(delta: float) -> void:
	if not is_timer_on:
		return
		
	_time += delta
	
	if Global.get_lap_counter() == num_lap_to_finish:
		is_timer_on = false
		is_live_race = false
		print("time: %d" % _time)
		Global.set_lap_counter(0)
		print("global lap counter to %s" % Global.get_lap_counter())


func set_current_time(time: float) -> void:
	print("set_current_time called! time = %1f" % time)


func get_current_time() -> float:
	return _time


func _on_Finish_body_entered(_body: Node):
	if is_live_race:
		return
	is_live_race = true # live_race state set to true
	is_timer_on = true  # turns timer on
	_time = 0 			# reset the timer
	print("timer started!")
