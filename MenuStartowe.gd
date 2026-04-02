extends Control

# Przycisk GRAJ
func _on_przycisk_graj_pressed():
	# Tu wpisz DOKŁADNĄ nazwę swojej sceny z poziomem (np. Poziom1.tscn)
	get_tree().change_scene_to_file("res://Poziom1.tscn")

# Przycisk JAK GRAĆ?
func _on_przycisk_instrukcja_pressed():
	$PanelInstrukcji.visible = true

# Przycisk ZAMKNIJ (ten wewnątrz instrukcji)
func _on_przycisk_zamknij_pressed():
	$PanelInstrukcji.visible = false

# Przycisk X (Wyjście)
func _on_przycisk_wyjdz_pressed():
	get_tree().quit()
