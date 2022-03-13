extends KinematicBody2D
class_name Player


## movement value exports ##
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

### Debug ###
var debug_draw: bool = false
var infinite_stamina: bool = false

### Time ###
var _time: float = 0 setget set_current_time, get_current_time
var is_timer_on: bool = false

### Stamina ###
export var max_stamina: float = 300
export var stamina_regeneration: float = 0.05
var stamina: float = max_stamina # <== starting stamina value


func _ready() -> void:
	pass
	
func set_current_time(time: float) -> void:
	print("set_current_time called! time = %1f" % time)

func get_current_time() -> float:
	return _time

func _physics_process(delta: float) -> void:
	# Movement
	acceleration = Vector2.ZERO
	_get_input()
	_apply_friction()
	_calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	_process_timer(delta) # player clock timer
	
	if Global.get_lap_counter() == 3:
		is_timer_on = false

	_handle_cheats()
	_handle_debug()

func _apply_friction() -> void:
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force

func _process_timer(delta: float) -> void:
	if not is_timer_on:
		return
	
	_time += delta

func _handle_cheats() -> void:
	if infinite_stamina:
		stamina = 1337
	elif not infinite_stamina and stamina > max_stamina:
		stamina = max_stamina

func _handle_debug() -> void:
	$CanvasLayer/LabelContainer.visible = false
	if debug_draw:
#		$CanvasLayer/LabelContainer/SpeedLabel.global_rotation = 0
		$CanvasLayer/LabelContainer.visible = true
		$CanvasLayer/LabelContainer/SpeedLabel.text = str("%3.1f" % velocity.length())

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


func _on_Finish_body_entered(body: Node):
	is_timer_on = true
