extends Control
signal go
export (int) var count_down_length
var seconds: int = count_down_length

var _active: bool = false setget set_active, is_active
var beep_sound = preload("res://assets/sound/countdownBeep.wav")

onready var timer_label: Control = $CenterContainer/Label

func _ready():
	$Beep.volume_db = -10
	$Go.volume_db = -10


func _on_Timer_timeout():
	seconds -= 1
	timer_label.text = str(seconds)
	if seconds == 0:
		$Go.play()
		timer_label.text = "GO"
		emit_signal("go")
		self._active = false
	else:
		$Beep.play()


func is_active():
	return _active

func set_active(value: bool):
	_active = value
	if _active:
		show()
		seconds = count_down_length
		$Timer.start()
		$Beep.play(0)
		timer_label.set_text(str(seconds))
	if not _active:
		$Timer.stop()

func _on_Go_finished():
	self._active = false
	hide()
	
