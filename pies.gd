extends Area2D

@export var predkosc = 200
@export var dystans = 500
@export var dystans_ostrzegawczy = 250.0 # Jak blisko musi być Kotka

var pozycja_startowa = 0
var kierunek = 1
var timer_szczekania = 0.0

func _ready():
	pozycja_startowa = position.y

func _process(delta):
	# 1. RUCH PSA
	position.y += predkosc * kierunek * delta
	
	if position.y > pozycja_startowa + dystans:
		kierunek = -1
	elif position.y < pozycja_startowa - 50:
		kierunek = 1

	# 2. LOGIKA SZCZEKANIA
	var kotka = get_tree().current_scene.find_child("MamaKotka", true, false)
	
	if kotka:
		var odleglosc = global_position.distance_to(kotka.global_position)
		
		if timer_szczekania > 0:
			timer_szczekania -= delta
			
		if odleglosc < dystans_ostrzegawczy and timer_szczekania <= 0:
			if has_node("DzwiekSzczekania"):
				$DzwiekSzczekania.play()
				var tw = create_tween()
				tw.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
				tw.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
				
				timer_szczekania = 1.5 

# --- NOWA SEKCJA: KOLIZJE ---
func _on_area_entered(area):
	# Pies sprawdza, czy to, co dotknął, to Mama Kotka
	if area.name == "MamaKotka":
		print("PIES: Złapałem Mamę!")
		if area.has_method("koniec_gry"):
			area.koniec_gry()
	
	# Jeśli area należy do grupy "ogon", pies NIC nie robi.
	# Dzięki temu przebiega przez małe kotki bez wywoływania przegranej.
	if area.is_in_group("ogon"):
		pass
