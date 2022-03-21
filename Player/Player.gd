extends KinematicBody2D
class_name Player


### Movement Exports ###
export (float) var traction_fast = 0.1
export (float) var traction_slow = 0.7
# forward acceleration force
export (int) var engine_power = 800
export (int) var braking = -450
export (float) var friction = -0.5
export (float) var drag = -0.001
export (int) var slip_speed = 400
# in degrees
export (int) var steering_angle = 5
export (int) var max_speed_reverse = 50


### Movement ###
var acceleration := Vector2.ZERO
var velocity := Vector2.ZERO
var steer_direction: float

### Time ###
var _time: float = 0 setget set_current_time, get_current_time
var is_timer_on: bool = false

### Wheel Base ###
var wheel_base


func _ready() -> void:
	_calculate_wheel_base()


func _physics_process(delta: float) -> void:
	# Movement
	acceleration = Vector2.ZERO
	_get_input()
	_apply_friction()
	_calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	_process_timer(delta) 
	if Global.get_lap_counter() == 3:
		is_timer_on = false
		

func _get_input() -> void:
	var turn: int = 0
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1	
	steer_direction = turn * deg2rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	elif Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power / 10
	elif Input.is_action_pressed("brake"):
		acceleration = transform.x * braking


func _apply_friction() -> void:
	# if velocity is less than 5, avoid velocity decreasing infinititly small by
	# setting it equal to (0, 0)
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force


func _calculate_steering(delta: float) -> void:
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
	rotation = new_heading.angle()


func _calculate_wheel_base() -> void:
	var front_wheel_pos: Position2D = $FrontWheel
	var back_wheel_pos: Position2D = $BackWheel
	wheel_base = abs(front_wheel_pos.position.x - back_wheel_pos.position.x)

"""
player clock timer
"""
func _process_timer(delta: float) -> void:
	if not is_timer_on:
		return
	_time += delta


func set_current_time(time: float) -> void:
	print("set_current_time called! time = %1f" % time)


func get_current_time() -> float:
	return _time


func _on_Finish_body_entered(_body: Node):
	# _body.to_string() -> "Player:[KinematicBody2D:2109]"
	is_timer_on = true
