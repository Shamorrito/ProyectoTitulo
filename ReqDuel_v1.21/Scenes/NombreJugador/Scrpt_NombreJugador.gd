extends Node2D

var NuevoJugador: String

func _ready():
	pass

func _process(_delta):
	pass

func _on_btn_name_input_pressed():
	NuevoJugador = $InputNuevoJugador.text.strip_edges().to_upper()
	if NuevoJugador != "":
		St_GlobalSignals.NombreUsuario = NuevoJugador
		get_tree().change_scene_to_file("res://Scenes/MetroLevel/SC_MetroLevel.tscn")
	else:
		$InputNuevoJugador.clear()
		$InputNuevoJugador.placeholder_text = "Porfavor, elige un nombre adecuado"
		print("no, \"", NuevoJugador, "\"")
