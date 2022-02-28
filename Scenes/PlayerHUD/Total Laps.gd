extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#If you know a better way to do this please let me know!
	text = String(get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_laps())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
