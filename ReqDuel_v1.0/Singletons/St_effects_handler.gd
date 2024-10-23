extends Node

var cardSelectorPre = preload("res://Scenes/CardSelector/SC_CardSelector.tscn")

func on_CardWaiting(card):
	var ataque
	get_tree().root.get_node("MetroLevel/UI").budgetCurrent += 2
	var turno = "Turno " + str(get_tree().root.get_node("MetroLevel/UI").day)  # Esto construye "Turno 1"
	var mainScene = get_tree().current_scene
	var ogList = mainScene.cardsList
	var card_scene = preload("res://Scenes/PlayerCard/SC_PlayerCard.tscn")
	if len(ogList) > 0:
		var dealed = card.ID
		ogList.erase(dealed)
		var card_data = St_GlobalSignals.card_data[dealed]
		# Crear una nueva instancia de la carta
		var new_card = card_scene.instantiate()
		new_card.ID = dealed
		# Datos a agregar
		new_card.cardName = card_data["cardName"]
		new_card.cost = card_data["cost"]
		new_card.description = card_data["description"]
		new_card.type = card_data["type"]
		new_card.Imagen = card_data["cardImage"]
		# Posicionar la carta en el tablero
		mainScene.add_child(new_card)
		new_card.onGame = true
		mainScene.get_node("CardSlots").card_Entered(new_card)
		new_card.placing = "hand"
		new_card.add_to_group("solution_cards")
		if len(ogList) == 1:
			mainScene.get_node("Deck/CardCount").text = "%d carta"%(len(ogList))
		else:
			mainScene.get_node("Deck/CardCount").text = "%d cartas"%(len(ogList))
			
		ataque = ("M13 -> %s" %[card.ID])
		St_GlobalSignals.Puntaje[turno]["MitigacionesJugadas"].append(ataque)
	mainScene.get_node("CardSelector").queue_free()
	mainScene.get_node("Overlay").visible = false
	for cartas in get_tree().get_nodes_in_group("solution_cards"):
		cartas.M13_act = false
	for cartas in get_tree().get_nodes_in_group("cards"):
		cartas.M13_act = false

func executeEffect (card, stake):
	match card.ID:
		"M01":
			get_tree().root.get_node("MetroLevel/EnemySlots").card_Exited(stake)
			stake.queue_free()
		"M02":
			get_tree().root.get_node("MetroLevel").dealCard()
			get_tree().root.get_node("MetroLevel").dealCard()
		"M03":
			stake.position = get_tree().root.get_node("MetroLevel/Graveyard").position
			get_tree().root.get_node("MetroLevel/CardSlots").card_Exited(stake)
			get_tree().root.get_node("MetroLevel").dealCard()
			stake.placing = "graveyard"
		"M04":
			stake.cost = stake.cost + 2
		"M05":
			get_tree().root.get_node("MetroLevel/UI").budgetCurrent += 2
		"M06":
			stake.cost = stake.cost - 1
		"M07":
			stake.cost = stake.cost + 1
		"M08":
			for cartas in get_tree().get_nodes_in_group("cards"):
				cartas.cost = cartas.cost + 1
		"M09":
			for cartas in get_tree().get_nodes_in_group("cards"):
				cartas.M09_act = true
		"M10":
			get_tree().root.get_node("MetroLevel/UI").M10_act = true
		"M11":
			pass
		"M12":
			if stake.parche == 0:
				stake.parche = stake.parche + 1
			elif stake.parche == 1:
				get_tree().root.get_node("MetroLevel/EnemySlots").card_Exited(stake)
				stake.queue_free()
		"M13":
			var cardSelector = cardSelectorPre.instantiate()
			var mainScene = get_tree().current_scene
			for cartas in get_tree().get_nodes_in_group("solution_cards"):
				cartas.M13_act = true
			for cartas in get_tree().get_nodes_in_group("cards"):
				cartas.M13_act = true
			mainScene.get_node("Overlay").visible = true
			mainScene.add_child(cardSelector)
			mainScene.get_node("CardSelector").drawCard()
			mainScene.get_node("CardSelector").drawCard()
			mainScene.get_node("CardSelector").drawCard()
			var cartasEliminadas = get_tree().root.get_node("MetroLevel/CardSelector").eliminadas
			for cartas in cartasEliminadas:
				mainScene.cardsList.append(cartas)
			St_GlobalSignals.CardWaiting.connect(on_CardWaiting)
			
		"M14":
			for cartas in get_tree().get_nodes_in_group("solution_cards"):
				if cartas.type != "Mitigacion":
					cartas.cost = cartas.cost - 1
					cartas.M14_act = true
