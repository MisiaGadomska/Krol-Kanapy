extends Area2D

func _on_area_entered(area):
	# Sprawdzamy czy to co w nas wjechało to Pies (Layer 2)
	if area.collision_layer == 2 or "Pies" in area.name:
		print("Pies złapał ogonek!")
		
		# get_tree() musi być wywołane wewnątrz funkcji!
		var mama = get_tree().current_scene.find_child("MamaKotka", true, false)
		
		if mama:
			mama.koniec_gry()
