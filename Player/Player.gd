extends KinematicBody2D
class_name Player

### exports ###

export (float) var traction_fast = 0.1
export (float) var traction_slow = 0.7
export (int) var engine_power = 800
export (int) var braking = -450
export (float) var friction = -0.9
export (float) var drag = -0.001
export (int) var slip_speed = 400
export (int) var steering_angle = 15
export (int) var wheel_base = 70
export (int) var max_speed_reverse = 50

### Debug ###
var debug_draw: bool = false
var infinite_stamina: bool = false

### Movement ###
var acceleration := Vector2.ZERO
var velocity := Vector2.ZERO
var steer_direction: float

### Time ###
var _time: float = 0
var timer_on: bool = false
var time_passed: String

### Stamina ###
export var max_stamina: float = 300
export var stamina_regeneration: float = 0.05
var stamina: float = max_stamina # <== starting stamina value

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	# Movement
	acceleration = Vector2.ZERO
	_get_input()
	_apply_friction()
	_calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	
	time_passed = _process_time(delta) # clock timer
	_handle_cheats()
	_handle_debug()
	


func _apply_friction() -> void:
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force

"""
Returns a formatted string for the time
"""
func _process_time(delta: float) -> String:
	_time += delta
	var milli_secs := fmod(_time, 1) * 1000
	var secs := fmod(_time, 60)
	var mins := fmod(_time, 60 * 60) / 60
	return "%02d : %02d : %03d" % [mins, secs, milli_secs]
	


func _handle_cheats() -> void:
	if infinite_stamina:
		stamina = 1337
	elif not infinite_stamina and stamina > max_stamina:
		stamina = max_stamina
		

func _handle_debug() -> void:
	$LabelContainer.visible = false
	if debug_draw:
		$LabelContainer.global_rotation = 0
		$LabelContainer.visible = true
		$LabelContainer/SpeedLabel.text = str("%3.1f" % velocity.length())


func _get_input() -> void:
	var turn: int = 0
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	steer_direction = turn * deg2rad(steering_angle)
	
	if Input.is_action_pressed("accelerate") and stamina > 0:
		acceleration = transform.x * engine_power
		stamina -= .25
	elif Input.is_action_pressed("accelerate") and stamina <= 1:
		acceleration = transform.x * engine_power / 10
	elif Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	else:
		if stamina < max_stamina:
			stamina += stamina_regeneration


func _calculate_steering(delta: float) -> void:
	var rear_wheel: Vector2 = position - transform.x * wheel_base/2.0
	var front_wheel: Vector2 = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading: Vector2 = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	$Skid.emitting = false
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0.1 and d < 1 and velocity.length() > slip_speed:
		$Skid.emitting = true
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	elif d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
