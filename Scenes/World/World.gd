extends Node2D
class_name Race_Map_1
#Total number of laps
export var total_laps: int = 3
var current_lap: int = 0
onready var checkpoints = $CheckpointContainer
onready var PlayerHUD = $CanvasLayer/PlayerHUD

#func _ready():
#	set_camera_limits()

#func set_camera_limits():
#	var map_limits = $TileMap.get_used_rect()
#	var map_cellsize = $TileMap.cell_size
#	var camera = $CarTest/Camera2D
#	camera.limit_left = map_limits.position.x * map_cellsize.x
#	camera.limit_top = map_limits.position.y * map_cellsize.y
#	camera.limit_right = map_limits.end.x * map_cellsize.x
#	camera.limit_bottom = map_limits.end.y * map_cellsize.y




func _on_FinishLine_body_entered(body):
	var checkpoints_collected = true
	if body is Player:
		for i in checkpoints.get_child_count():
			if(!checkpoints.get_child(i).get_collected()):
				checkpoints_collected = false
		if checkpoints_collected:
			current_lap+=1
			print("Lap Complete")
			PlayerHUD.LapsCompleted.text = str(current_lap)
			if(current_lap == total_laps):
				print("You Win!")
		elif !checkpoints_collected:
			print("More Checkpoints Needed")
		else: 
			print("JW")
