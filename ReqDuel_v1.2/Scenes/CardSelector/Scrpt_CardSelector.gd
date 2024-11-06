extends Node2D

var cardsList: Array
var card_scene: PackedScene
var eliminadas: Array
func _ready():
	cardsList = get_parent().cardsList
	card_scene = preload("res://Scenes/PlayerCard/SC_PlayerCard.tscn")

func drawCard():
	if len(cardsList) > 0:
		var dealed = cardsList.pop_at(randi_range(0, len(cardsList)-1))
		eliminadas.append(dealed)
		var card_data = St_GlobalSignals.card_data[dealed]
		# Crear una nueva instancia de la carta
		var new_card = card_scene.instantiate()
		new_card.ID = dealed
		new_card.cardName = card_data["cardName"]
		new_card.cost = card_data["cost"]
		new_card.description = card_data["description"]
		new_card.type = card_data["type"]
		new_card.Imagen = card_data["cardImage"]
		# Posicionar la carta en el tablero
		add_child(new_card)
		#new_card.onGame = true
		$CardSlots.card_Entered(new_card)
		new_card.placing = "waiting"
