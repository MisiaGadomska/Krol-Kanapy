extends Node2D

func _ready():
	var ekran = get_node("%EkranPoziomu") 
	
	if ekran:
		get_tree().paused = true # Zatrzymujemy grę na start
		
		await ekran.pokaz_poziom(1) 
		
		get_tree().paused = false # Wracamy do gry po zniknięciu napisu
		print("START GRY!")
	else:
		print("BŁĄD: Dalej nie widzę EkranPoziomu!")
