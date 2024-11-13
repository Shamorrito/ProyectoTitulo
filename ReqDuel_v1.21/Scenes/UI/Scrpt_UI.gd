extends Node2D
var budgetMax: int
var budgetCurrent: int
var day: int
var M10_act = false

func _ready():
	budgetCurrent = 3
	budgetMax = 3
	day = 1
	$Calendario/txtDays.text = "Día 1"
	$Presupuesto/txtBudget.text = "3$/3$"

func _process(_delta):
	$Presupuesto/txtBudget.text = "%d$/%d$" %[budgetCurrent, budgetMax]

func _on_btn_pass_turn_pressed():
	if budgetMax < 10:
		budgetMax += 1
	else:
		pass
	budgetCurrent = budgetMax
	if M10_act:
		budgetCurrent = budgetCurrent + 3
		M10_act = false
	St_GlobalSignals.Puntaje["Puntos"]["diasTranscurridos"] = day
	day += 1
	
	if day > 10:
		get_tree().change_scene_to_file("res://Scenes/PantallaVictoria/SC_PantallaVictoria.tscn")
	$Calendario/txtDays.text = "Día %d" %day
	St_GlobalSignals.PassTurnButtonPressed.emit()
