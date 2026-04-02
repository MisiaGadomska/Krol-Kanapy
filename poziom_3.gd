extends Node2D

func _ready():
	var ekran = get_node_or_null("%EkranPoziomu")
	if ekran:
		get_tree().paused = true
		await ekran.pokaz_poziom(3) 
		get_tree().paused = false
