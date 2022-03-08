extends KinematicBody2D
class_name Player


### exports ###
export (bool) var debug_draw = false
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


### Movement ###
var acceleration := Vector2.ZERO
var velocity := Vector2.ZERO
var steer_direction: float


### Stamina ###
export var max_stamina: float = 300
export var stamina_regeneration: float = 0.05
var stamina: float = max_stamina # <== starting stamina value


func _physics_process(delta: float) -> void:
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)


func apply_friction() -> void:
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force


func get_input() -> void:
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


func calculate_steering(delta: float) -> void:
	var rear_wheel: Vector2 = position - transform.x * wheel_base/2.0
	var front_wheel: Vector2 = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading: Vector2 = (front_wheel - rear_wheel).normalized()
	var traction: float = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d: float = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()


func _draw() -> void:
	if debug_draw:
		draw_circle(Vector2(wheel_base/2.0, 0), 5, Color(1, 0, 0))
		draw_circle(Vector2(-wheel_base/2.0, 0), 5, Color(1, 0, 0))