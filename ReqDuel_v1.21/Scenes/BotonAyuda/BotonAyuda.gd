extends Node2D

@onready var ayudaActual: Label = $BtnAyuda/MenuAyuda/LabelInicio
@onready var descSC: Label = $BtnAyuda/MenuAyuda/LabelSolucion/CartaSolucion/Description
@onready var descMG: Label = $BtnAyuda/MenuAyuda/LabelMitigacion/CartaMitigacion/Description
@onready var descSH_N: Label = $BtnAyuda/MenuAyuda/LabelStake/CartaSH_N/Description
@onready var descSH_P: Label = $BtnAyuda/MenuAyuda/LabelStake/CartaSH_P/Description
var descAct: Label
var descAct2: Label

func _ready():
	ayudaActual = $BtnAyuda/MenuAyuda/LabelInicio

func _on_btn_ayuda_toggled(toggled_on):
	$BtnAyuda/MenuAyuda.visible = toggled_on  # Cambiar la visibilidad del menú de ayuda
	if toggled_on:
		for cartas in get_tree().get_nodes_in_group("solution_cards"):
			cartas.M12_act = true
		for cartas in get_tree().get_nodes_in_group("cards"):
			cartas.M12_act = true
		$BtnAyuda.text = "X"
		ayudaActual = $BtnAyuda/MenuAyuda/LabelInicio
		ayudaActual.visible = true
		$AyudaOverlay.visible = true
	else:
		for cartas in get_tree().get_nodes_in_group("solution_cards"):
			cartas.M12_act = false
		for cartas in get_tree().get_nodes_in_group("cards"):
			cartas.M12_act = false
		$BtnAyuda.text = "i"
		ayudaActual.visible = false
		ayudaActual = $BtnAyuda/MenuAyuda/LabelInicio
		$AyudaOverlay.visible = false

func _on_ayuda_objetivo_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/LabelObjetivo
	ayudaActual.visible = true

func _on_ayuda_solucion_pressed():
	descAct = descSC
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/LabelSolucion
	ayudaActual.visible = true

func _on_ayuda_mitigacion_pressed():
	descAct = descMG
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/LabelMitigacion
	ayudaActual.visible = true
	
func _on_ayuda_stake_pressed():
	descAct = descSH_N
	descAct2 = descSH_P
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/LabelStake
	ayudaActual.visible = true

func _on_ayuda_pres_pressed():
	ayudaActual.visible = false
	ayudaActual = $BtnAyuda/MenuAyuda/LabelPres
	ayudaActual.visible = true

func _on_panel_mouse_entered():
	descAct.visible = true
func _on_panel_mouse_exited():
	descAct.visible = false

func _on_panel_2_mouse_entered():
	descAct2.visible = true
func _on_panel_2_mouse_exited():
	descAct2.visible = false
