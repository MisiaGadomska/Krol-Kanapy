extends CanvasLayer

@onready var napis = $NapisPoziomu

func _ready():
	# Na początku ukrywamy cały ekran
	hide()

func pokaz_poziom(numer):
	# Ustawiamy tekst (np. LEVEL 1 lub LEVEL 2)
	napis.text = "LEVEL " + str(numer)
	show() # Pokazujemy ekran
	
	# --- EFEKT PULSOWANIA NA CZERWONO (Tween) ---
	var tween = create_tween()
	
	# Zmieniamy kolor obrysu na czerwony w 0.5 sekundy
	tween.tween_property(napis, "theme_override_colors/font_outline_color", Color.RED, 0.5)
	# Wracamy do niebieskiego w 0.5 sekundy
	tween.tween_property(napis, "theme_override_colors/font_outline_color", Color.BLUE, 0.5)
	# Powtarzamy to 2 razy (łącznie 2 sekundy pulsowania)
	tween.set_loops(2)
	
	# Czekamy te 2 sekundy
	await get_tree().create_timer(2.0).timeout
	
	# Chowamy ekran i wznawiamy grę
	hide()
	get_tree().paused = false
