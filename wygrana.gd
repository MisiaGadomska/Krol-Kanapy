extends Control

func _ready():
	# 1. Odmrażamy grę
	get_tree().paused = false
	
	# 2. Puszczamy muzykę
	if has_node("WielkieFanfary"):
		$WielkieFanfary.play()
	
	# 3. --- EFEKT PULSOWANIA OBRYSU (Tween) ---
	# 3. --- EFEKT PULSOWANIA OBRYSU (Tween) ---
	var napis = get_node_or_null("NapisGratulacje")
	if napis:
		# Ustawiamy punkt obrotu na środek, żeby pulsował ładnie ze środka
		napis.pivot_offset = napis.size / 2
		
		var tween = create_tween().set_loops() # Zapętlamy od razu
		
		# PULSOWANIE KOLOREM (Z Hot Pink do Sky Blue)
		tween.tween_property(napis, "modulate", Color.HOT_PINK, 0.6)
		tween.tween_property(napis, "modulate", Color.SKY_BLUE, 0.6)
		
		# Ustawiamy zapętlenie w nieskończoność (0 oznacza nieskończoność w Tween)
		tween.set_loops() 

# --- Przyciski ---
func _on_przycisk_restart_pressed():
	get_tree().change_scene_to_file("res://Poziom1.tscn")

func _on_przycisk_wyjdz_pressed():
	get_tree().quit()
