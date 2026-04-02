extends Control

func _ready():
	hide()
	process_mode = PROCESS_MODE_ALWAYS

func pokaz_koniec():
	show()

func _on_przycisk_restart_pressed():
	get_tree().paused = false 

	get_tree().change_scene_to_file("res://Poziom1.tscn")
