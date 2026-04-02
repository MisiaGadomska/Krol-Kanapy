extends Node2D

func _ready():
	var ekran = get_node("%EkranPoziomu") 
	
	if ekran:
		get_tree().paused = true
		
		await ekran.pokaz_poziom(2) 
		
		get_tree().paused = false
		print("START POZIOMU 2!")
	else:
		await $CanvasLayer/EkranPoziomu.pokaz_poziom(2)
		get_tree().paused = false
