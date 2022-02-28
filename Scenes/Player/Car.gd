extends KinematicBody2D

export var wheel_base = 70
export var steering_angle = 15
export var engine_power = 800
export var friction = -0.9
export var drag = -0.001
export var braking = -450
export var max_speed_reverse = 50
export var slip_speed = 400
export var traction_fast = 0.1
export var traction_slow = 0.7

export var stamina = 100000000
export var max_stamina = 100
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_direction
var total_checkpoints = 0
var collected_checkpoints = 0
var current_lap=1
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

	if Input.is_action_pressed("accelerate"):
		if (stamina > 0):
			acceleration = transform.x * engine_power
			stamina -= .25
	elif Input.is_action_pressed("brake"):
		if (stamina > 0):
			acceleration = transform.x * braking
			stamina -= .35
	else: 
		if (stamina < max_stamina):
			stamina += .5
		
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
	
func collect_checkpoint():
	collected_checkpoints+= 1
	print(collected_checkpoints)
func set_checkpoint_count(cpc):
	total_checkpoints = cpc
func finish_line():
	if(total_checkpoints <= collected_checkpoints && current_lap < get_parent().get_laps()):
		current_lap+=1
		print(String(current_lap))
		get_parent().get_node("CanvasLayer").get_node("PlayerHUD").get_node("Panel2/VBoxContainer/Speedometer/Current Lap").text = String(current_lap) + " /"
		collected_checkpoints = 0
		for i in get_parent().get_node("Checkpoints").get_children():
			i.set_collected(false)
	elif(total_checkpoints > collected_checkpoints):
		print("Do Nothing")
	else:
		print("You Win!")
