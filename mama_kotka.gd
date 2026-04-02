extends Area2D

# --- ZMIENNE GŁÓWNE ---
var skok = 64
var punkty = 0
var stara_pozycja_globalna = Vector2.ZERO
var czy_koniec = false
var czy_wygrana = false 
var pozostały_czas = 60.0
var timer_aktywny = false

# --- ZASOBY I KOLORY ---
var scena_malego_kotka = preload("res://MalyKotek.tscn")
var kolory_ogonka = [
	Color(0.55, 0.55, 0.55), Color(0.46, 0.23, 0.0), 
	Color(0.25, 0.25, 0.25), Color(1.0, 1.0, 1.0), 
	Color(1.0, 0.54, 0.21)
]

var ogon = []
var historia_pozycji = []

# --- START POZIOMU ---
func _ready():
	z_index = 5
	czy_koniec = true 
	
	# Ustawienie czasu zależnie od poziomu
	var nazwa_mapy = get_tree().current_scene.name
	if nazwa_mapy == "Poziom4":
		pozostały_czas = 80.0
	else:
		pozostały_czas = 60.0
	
	var ep = get_node_or_null("%EkranPoziomu")
	if ep: ep.show()
	
	await get_tree().create_timer(2.0).timeout 
	
	if ep: ep.hide()
	czy_koniec = false
	timer_aktywny = true # Włączamy odliczanie po zniknięciu napisu
	
# --- PĘTLA RUCHU ---
func _process(delta):
	if czy_koniec or czy_wygrana: return
	
	# --- LOGIKA TIMERA ---
	if timer_aktywny:
		pozostały_czas -= delta
		# Aktualizacja napisu (jeśli masz Label o nazwie LicznikCzasu)
		var label_czas = get_node_or_null("%LicznikCzasu")
		if label_czas:
			label_czas.text = "Czas: " + str(int(pozostały_czas))
		
		# Koniec czasu = Przegrana
		if pozostały_czas <= 0:
			print("PRZEGRANA: Koniec czasu!")
			koniec_gry()
	stara_pozycja_globalna = position
	var ruszyl_sie = false
	
	if Input.is_action_just_pressed("gora"):
		position.y -= skok
		ruszyl_sie = true
	elif Input.is_action_just_pressed("dol"):
		position.y += skok
		ruszyl_sie = true
	elif Input.is_action_just_pressed("lewo"):
		position.x -= skok
		ruszyl_sie = true
	elif Input.is_action_just_pressed("prawo"):
		position.x += skok
		ruszyl_sie = true

	if ruszyl_sie:
		historia_pozycji.insert(0, stara_pozycja_globalna)
		if historia_pozycji.size() > ogon.size():
			historia_pozycji.pop_back()
		aktualizuj_ogon()
		
		if position.x < 32 or position.x > 1120 or position.y < 32 or position.y > 625:
			koniec_gry()

# --- MECHANIKA OGONA ---
func aktualizuj_ogon():
	for i in range(ogon.size()):
		if i < historia_pozycji.size():
			ogon[i].position = historia_pozycji[i]
			if not ogon[i].is_in_group("ogon"):
				ogon[i].add_to_group("ogon")
			# Ustawiamy ogon na warstwie 3 (pod Mamą, ale nad myszką i tłem)
			ogon[i].z_index = 3

# --- KOLIZJE ---
func _on_area_entered(area):
	if czy_wygrana or czy_koniec: return
	
	# --- 1. ZBIERANIE MYSZKI ---
	if "Mysz" in area.name:
		$DzwiekMyszki.play()
		area.z_index = 2 # Myszka na warstwie 2 (nad tłem, pod ogonem)
		
		var wolne = false
		while not wolne:
			var proba = Vector2(randf_range(100, 1050), randf_range(100, 550))
			
			if proba.distance_to(position) < 150:
				continue
				
			var query = PhysicsPointQueryParameters2D.new()
			query.position = proba
			# Maska 2 powinna być ustawiona dla mebli i choinek w Inspektorze!
			query.collision_mask = 2 
			query.collide_with_areas = true
			
			var result = get_world_2d().direct_space_state.intersect_point(query)
			if result.is_empty():
				area.position = proba
				wolne = true

		punkty += 1
		var licznik = get_node_or_null("%LicznikPunktow")
		if licznik: licznik.text = "" + str(punkty)
		
		var nowy = scena_malego_kotka.instantiate()
		nowy.get_node("Sprite2D").modulate = kolory_ogonka.pick_random()
		nowy.z_index = 3 # Małe kotki pod Mamą
		nowy.position = stara_pozycja_globalna if ogon.size() == 0 else ogon.back().position
		get_parent().call_deferred("add_child", nowy)
		ogon.append(nowy)
		
		if has_node("AudioStreamPlayer2D"): $AudioStreamPlayer2D.play()
		sprawdz_czy_nastepny_poziom()
		return

	# --- 2. KOLIZJA Z OGONEM ---
	if area.is_in_group("ogon"):
		var indeks = ogon.find(area)
		if indeks > 2:
			print("PRZEGRANA: Własny ogon! Indeks: ", indeks)
			koniec_gry()
		return

	# --- 3. PRZESZKODY I PIES ---
	if area.is_in_group("przeszkody") or "Przeszkoda" in area.name:
		print("PRZEGRANA: Mebel!")
		koniec_gry()
		return
		
	elif "Pies" in area.name:
		print("KOLIZJA Z PSEEM: Sprawdzam kto oberwał...")
		koniec_gry()
		return

# --- KONIEC GRY ---
func koniec_gry():
	if czy_koniec or czy_wygrana: return
	czy_koniec = true
	
	$DzwiekUderzenia.play()
	var ekran = get_node_or_null("%EkranGameOver")
	if ekran:
		ekran.show()
		$DzwiekGameOver.play()
		await get_tree().process_frame
		get_tree().paused = true
	else:
		get_tree().paused = true

# --- POZIOMY ---
func sprawdz_czy_nastepny_poziom():
	var nazwa = get_tree().current_scene.name
	var awans = false
	
	if nazwa == "Poziom1" and punkty >= 5: awans = true
	elif nazwa == "Poziom2" and punkty >= 7: awans = true
	elif nazwa == "Poziom3" and punkty >= 9: awans = true
	elif nazwa == "Poziom4" and punkty >= 11:
		czy_wygrana = true
		get_tree().paused = false
		get_tree().call_deferred("change_scene_to_file", "res://Wygrana.tscn")
		return

	if awans:
		czy_wygrana = true 
		if has_node("DzwiekWygranej"): $DzwiekWygranej.play()
		await get_tree().create_timer(1.0).timeout
		var mapy = {"Poziom1": "Poziom2", "Poziom2": "Poziom3", "Poziom3": "Poziom4"}
		get_tree().call_deferred("change_scene_to_file", "res://" + mapy[nazwa] + ".tscn")

func _on_przycisk_x_pressed():
	# Wersja bezpieczna dla przeglądarki (Restart zamiast Quit)
	get_tree().paused = false
	get_tree().reload_current_scene()
