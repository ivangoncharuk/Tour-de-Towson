extends Node

var _lap_counter: int = 0 setget , get_lap_counter
var _max_laps: int = 3

func _ready():
	pass

func increment_lap_counter():
	_lap_counter += 1
	print(_lap_counter)

func get_lap_counter() -> int:
	return _lap_counter
