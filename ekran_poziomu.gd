extends CanvasLayer

@onready var napis = $NapisPoziomu

func _ready():
	# Na początku ukrywamy cały ekran
	hide()

func pokaz_poziom(numer):
	# Ustawiamy tekst
	napis.text = "LEVEL " + str(numer)
	show()
	
	#EFEKT PULSOWANIA
	var tween = create_tween()
	
	# Zmieniamy kolor
	tween.tween_property(napis, "theme_override_colors/font_outline_color", Color.RED, 0.5)
	tween.tween_property(napis, "theme_override_colors/font_outline_color", Color.BLUE, 0.5)
	tween.set_loops(2)
	
	await get_tree().create_timer(2.0).timeout
	
	hide()
	get_tree().paused = false
