extends Control
export (int) var seconds = 5
onready var timer_label: Control = $CenterContainer/VBoxContainer/Label
var countdown_beep = preload("res://assets/music/countdownBeep.wav")
func _ready():
	$countdownBeep.play()
	timer_label.set_text(str(seconds))
func _on_Timer_timeout():
	seconds-=1
	if (!$countdownBeep.is_playing() && seconds > 0):
		$countdownBeep.play()
	timer_label.set_text(str(seconds))
	if(seconds == 0):
		$go_sound.play()
		timer_label.set_text("GO")
	if(seconds < 0):
		$Timer.stop()
		get_tree().paused = false
		self.visible = false
