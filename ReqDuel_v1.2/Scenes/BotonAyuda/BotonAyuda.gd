extends Node2D

signal btn_ayuda_toggled(toggled_on)  # Definir la señal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_ayuda_toggled(toggled_on):
	$BtnAyuda/MenuAyuda.visible = toggled_on  # Cambiar la visibilidad del menú de ayuda
	if toggled_on:
		$AyudaOverlay.visible = true
		print("UNO")
	else:
		$AyudaOverlay.visible = false
		print("DOS")

func _on_ayuda_objetivo_toggled(toggled_on):
	if toggled_on:
		$BtnAyuda/MenuAyuda/AyudaObjetivo/LabelObjetivo.visible = true
	else:
		$BtnAyuda/MenuAyuda/AyudaObjetivo/LabelObjetivo.visible = false

func _on_ayuda_solucion_toggled(toggled_on):
	if toggled_on:
		$BtnAyuda/MenuAyuda/AyudaSolucion/LabelSolucion.visible = true
	else:
		$BtnAyuda/MenuAyuda/AyudaSolucion/LabelSolucion.visible = false
		
func _on_ayuda_mitigacion_toggled(toggled_on):
	if toggled_on:
		$BtnAyuda/MenuAyuda/AyudaMitigacion/LabelMitigacion.visible = true
	else:
		$BtnAyuda/MenuAyuda/AyudaMitigacion/LabelMitigacion.visible = false
