extends Control

func _ready():
	# Na starcie chowamy ekran
	hide()
	# Upewniamy się, że ten ekran reaguje nawet gdy gra stoi
	process_mode = PROCESS_MODE_ALWAYS

func pokaz_koniec():
	show()

func _on_przycisk_restart_pressed():
	# KLUCZOWA LINIA: Odmrażamy grę!
	get_tree().paused = false 
	
	# Teraz ładujemy poziom - myszki będą już działać!
	get_tree().change_scene_to_file("res://Poziom1.tscn")
