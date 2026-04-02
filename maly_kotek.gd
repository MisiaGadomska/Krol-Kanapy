extends Area2D

func _on_area_entered(area):
	if area.collision_layer == 2 or "Pies" in area.name:
		print("Pies złapał ogonek!")
	
		var mama = get_tree().current_scene.find_child("MamaKotka", true, false)
		
		if mama:
			mama.koniec_gry()
