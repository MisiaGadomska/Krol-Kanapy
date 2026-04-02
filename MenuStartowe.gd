extends Control

# Przycisk GRAJ
func _on_przycisk_graj_pressed():
	get_tree().change_scene_to_file("res://Poziom1.tscn")

# Przycisk JAK GRAĆ?
func _on_przycisk_instrukcja_pressed():
	$PanelInstrukcji.visible = true

# Przycisk ZAMKNIJ 
func _on_przycisk_zamknij_pressed():
	$PanelInstrukcji.visible = false

# Przycisk X 
func _on_przycisk_wyjdz_pressed():
	get_tree().quit()
