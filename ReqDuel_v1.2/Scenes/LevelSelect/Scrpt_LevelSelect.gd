extends Node2D

func _ready():
	pass

func _process(_delta):
	pass

func _on_btn_1_metro_pressed():
	get_tree().change_scene_to_file("res://Scenes/NombreJugador/SC_NombreJugador.tscn")

func _on_btn_2tba_pressed():
	pass

func _on_btn_3tba_pressed():
	pass

func _on_volver_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen/SC_TitleScreen.tscn")
