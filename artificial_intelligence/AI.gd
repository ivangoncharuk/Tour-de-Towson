extends KinematicBody2D
class_name AI


### Movement Exports ###
export(float) var traction_fast = 0.1
export(float) var traction_slow = 0.7
# forward acceleration force
export(int) var engine_power = 800
export(int) var braking = -450
export(float) var friction = -0.5
export(float) var drag = -0.001
export(int) var slip_speed = 400
# in degrees
export(int) var max_speed_reverse = 50

### Movement ###
export var acceleration := Vector2.ZERO
export var velocity := Vector2.ZERO
export var steer_force = 0.1

### AI ###
export(int) var look_ahead = 200
export(int) var num_rays = 8
var new_color: Color
var last_loc: Vector2
var rng = RandomNumberGenerator.new()

# context array
var ray_directions := []
var interest := []
var danger := []

var chosen_dir := Vector2.ZERO

func _ready() -> void:
	_set_color()
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for ray in num_rays:
		var angle = ray * 2 * PI / num_rays
		ray_directions[ray] = Vector2.RIGHT.rotated(angle)


func _physics_process(delta: float) -> void:
	# Movement
	acceleration = Vector2.ZERO
	
	_is_stuck()
	_set_interest()
	_set_danger()
	_choose_direction()
	_apply_friction()
	
	var desired_velocity = chosen_dir.rotated(rotation) * engine_power
	velocity = velocity.linear_interpolate(desired_velocity, steer_force)
	rotation = velocity.angle()
	velocity = move_and_slide(velocity)
#	move_and_collide(velocity * delta)

# Set interest in each slot based on world direction
func _set_interest():
	if not owner and owner.has_method("get_path_direction"):
		_set_default_interest()
		return
	var path_direction = owner.get_path_direction(position)
	for i in num_rays:
		var d = ray_directions[i].rotated(rotation).dot(path_direction)
		interest[i] = max(0, d)
		# If no world path, use default interest

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


func _choose_direction():
	# Eliminate interest in slots with danger
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	# Choose direction based on remaining interest
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()

func _is_stuck(from: int = -50, to: int = 50) -> void:
	if get_position() != last_loc:
		last_loc = get_position()
	else:
		position.x += rng.randi_range(from, to)
		position.y += rng.randi_range(from, to)


func _apply_friction() -> void:
	# avoids infinitly small velocity
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	
	var friction_force: Vector2 = velocity * friction
	var drag_force: Vector2 = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force


func _set_color() -> void:
	randomize()
	modulate = Color(randf(), randf(), randf(), 1.0)
