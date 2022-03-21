extends Node

var _lap_counter: int = 0 setget set_lap_counter, get_lap_counter
var _max_laps: int = 3

func _ready():
	pass
	
func increment_lap_counter():
	_lap_counter += 1

func get_lap_counter() -> int:
	return _lap_counter
	
func set_lap_counter(param: int) -> void:
	_lap_counter = param
	print("lap counter has been changed by setter")

