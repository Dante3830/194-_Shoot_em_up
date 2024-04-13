extends Control

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Global.health = 10

func _on_quit_button_pressed():
	get_tree().quit()
