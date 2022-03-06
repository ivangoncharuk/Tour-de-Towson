extends Node2D
class_name Race_Map_1
#Total number of laps
export var total_laps: int = 3
var current_lap: int = 0
onready var checkpoints = $CheckpointContainer

func _ready():
	get_node("CanvasLayer/PlayerHUD/Panel/VBoxContainer/LapCounter/TotalLaps").text = str(total_laps)
#	set_camera_limits()

#func set_camera_limits():
#	var map_limits = $TileMap.get_used_rect()
#	var map_cellsize = $TileMap.cell_size
#	var camera = $CarTest/Camera2D
#	camera.limit_left = map_limits.position.x * map_cellsize.x
#	camera.limit_top = map_limits.position.y * map_cellsize.y
#	camera.limit_right = map_limits.end.x * map_cellsize.x
#	camera.limit_bottom = map_limits.end.y * map_cellsize.y



#Handles FinishLine functionality, print statements to be changed at a later point
func _on_FinishLine_body_entered(body):
	var checkpoints_collected = true
	if body is Player:
		for i in checkpoints.get_child_count():
			if(!checkpoints.get_child(i).get_collected()):
				checkpoints_collected = false
		if checkpoints_collected:
			current_lap+=1
			#Sets all Checkpoints to not collected.
			for i in checkpoints.get_child_count():
				checkpoints.get_child(i).set_collected(false)
			get_node("CanvasLayer/PlayerHUD/Panel/VBoxContainer/LapCounter/LapsCompleted").text = str(total_laps) + " /"
			print("Lap Complete")
			if(current_lap == total_laps):
				print("You Win!")
		elif !checkpoints_collected:
			print("More Checkpoints Needed")
		else: 
			print("JW")
