extends Control

signal resume_pressed
signal quit_pressed
signal exit_game_pressed


func _on_Resume_pressed():
	emit_signal("resume_pressed")


func _on_Quit_pressed():
	emit_signal("quit_pressed")


func _on_ExitGame_pressed():
	emit_signal("exit_game_pressed")
