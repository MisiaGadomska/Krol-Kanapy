extends Node2D

func _ready():
	# Znajdujemy nasz napis (najlepiej użyć % Unikalnej Nazwy, jeśli ją ustawiłaś)
	var ekran = get_node("%EkranPoziomu") 
	
	if ekran:
		get_tree().paused = true # Zatrzymujemy grę, żeby gracz zobaczył "LEVEL 2"
		
		# WAŻNE: Musisz dopisać "await", żeby Godot poczekał 2 sekundy
		await ekran.pokaz_poziom(2) 
		
		get_tree().paused = false # Dopiero teraz Mama Kotka może zacząć łapać myszki
		print("START POZIOMU 2!")
	else:
		# Jeśli nie używasz %, upewnij się, że ścieżka poniżej jest idealna:
		await $CanvasLayer/EkranPoziomu.pokaz_poziom(2)
		get_tree().paused = false
