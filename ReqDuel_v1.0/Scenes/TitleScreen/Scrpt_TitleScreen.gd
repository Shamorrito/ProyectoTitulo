extends Node2D

func _ready():
	pass

func _process(_delta):
	pass

func _on_btn_level_select_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelSelect/SC_LevelSelect.tscn")
	
func _on_btn_ayuda_pressed():
	get_tree().change_scene_to_file("res://Scenes/PantallaAyuda/SC_Ayuda.tscn")
