extends Node2D

@onready var ayudaActual: Label = $BtnAyuda/MenuAyuda/AyudaInicio

func _ready():
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaInicio

func _on_btn_ayuda_toggled(toggled_on):
	$BtnAyuda/MenuAyuda.visible = toggled_on  # Cambiar la visibilidad del menú de ayuda
	if toggled_on:
		for cartas in get_tree().get_nodes_in_group("solution_cards"):
			cartas.M12_act = true
		for cartas in get_tree().get_nodes_in_group("cards"):
			cartas.M12_act = true
		$BtnAyuda.text = "X"
		ayudaActual = $BtnAyuda/MenuAyuda/AyudaInicio
		ayudaActual.visible = true
		$AyudaOverlay.visible = true
	else:
		for cartas in get_tree().get_nodes_in_group("solution_cards"):
			cartas.M12_act = false
		for cartas in get_tree().get_nodes_in_group("cards"):
			cartas.M12_act = false
		$BtnAyuda.text = "i"
		ayudaActual.visible = false
		ayudaActual = $BtnAyuda/MenuAyuda/AyudaInicio
		$AyudaOverlay.visible = false

func _on_ayuda_objetivo_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaObjetivo/LabelObjetivo
	ayudaActual.visible = true

func _on_ayuda_solucion_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaSolucion/LabelSolucion
	ayudaActual.visible = true

func _on_ayuda_mitigacion_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaMitigacion/LabelMitigacion
	ayudaActual.visible = true
	
func _on_ayuda_pres_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaPres/LabelPres
	ayudaActual.visible = true

func _on_ayuda_stake_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/AyudaStake/LabelStake
	ayudaActual.visible = true
