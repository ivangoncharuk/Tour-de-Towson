extends KinematicBody2D

export var debug_draw = false

### Constants ###
export var traction_fast = 0.1
export var traction_slow = 0.7
export var engine_power = 800
export var braking = -450
export var friction = -0.9
export var drag = -0.001
export var slip_speed = 400
export var steering_angle = 15
export var wheel_base = 70
export var max_speed_reverse = 50


### Movement ###
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_direction


### Stamina ###
export var max_stamina = 100
export var stamina_regeneration = 0.05

var stamina = max_stamina / 2 # <== starting stamina value


func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	
	
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
	
	
func get_input():
	var turn = 0
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
			
	if Input.is_action_just_pressed("ui_focus"):
		pass
		
		
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	
	
func _draw():
	if debug_draw:
		draw_circle(Vector2(wheel_base/2.0, 0), 5, Color(1, 0, 0))
		draw_circle(Vector2(-wheel_base/2.0, 0), 5, Color(1, 0, 0))
