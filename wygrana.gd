extends Control

func _ready():
	#Odmrażamy grę
	get_tree().paused = false
	
	#Puszczamy muzykę
	if has_node("WielkieFanfary"):
		$WielkieFanfary.play()
	
	#EFEKT PULSOWANIA
	var napis = get_node_or_null("NapisGratulacje")
	if napis:
		napis.pivot_offset = napis.size / 2
		
		var tween = create_tween().set_loops() 
		
		tween.tween_property(napis, "modulate", Color.HOT_PINK, 0.6)
		tween.tween_property(napis, "modulate", Color.SKY_BLUE, 0.6)
		
		tween.set_loops() 


func _on_przycisk_restart_pressed():
	get_tree().change_scene_to_file("res://Poziom1.tscn")

func _on_przycisk_wyjdz_pressed():
	get_tree().quit()
