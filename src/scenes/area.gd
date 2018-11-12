extends Node2D

func _input(event):
	if Input.is_action_just_pressed("game.quit"): get_tree().quit()
	elif Input.is_action_just_pressed("game.restart"): get_tree().reload_current_scene()