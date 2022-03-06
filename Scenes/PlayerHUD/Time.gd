extends Label
var seconds = 0
var minutes = 0
var str_seconds 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if seconds > 59:
		minutes+=1
	if seconds < 10:
		str_seconds = "0" + str(seconds)
	else: 
		str_seconds = str(seconds)
	set_text(str(minutes) + ":" + str_seconds)
	pass



func _on_Timer_timeout():
	seconds+=1
	pass # Replace with function body.
