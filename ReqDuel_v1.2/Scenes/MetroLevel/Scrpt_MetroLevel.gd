extends Node2D

var cardsList: Array
var enemycardsList: Array
var selectedCard: Node2D 
var card_scene: PackedScene
var cartaAtacada: Node2D
var cartaMitigacion: Node2D
var Tablero: Sprite2D

func _ready():
	$BGM.play()
	St_GlobalSignals.reset_puntajes()
	for key in St_GlobalSignals.Puntaje["Puntos"]:
		St_GlobalSignals.Puntaje["Puntos"][key] = 0
	St_GlobalSignals.PassTurnButtonPressed.connect(on_PassTurnButtonPressed)
	St_GlobalSignals.CardSelected.connect(on_CardSelected)
	cardsList = St_GlobalSignals.card_data.keys()
	enemycardsList = St_GlobalSignals.enemy_card_data.keys()
	$Deck/CardCount.text = "%d cartas"%(len(cardsList))
	card_scene = preload("res://Scenes/PlayerCard/SC_PlayerCard.tscn") 
	$CardSlots.position = Vector2(928,896)
	$EnemySlots.position = Vector2(928,192)
	for i in range(5):
		dealCard()
	chooseEnemy()
	
func dealCard(): #robar carta nueva
	if len(cardsList) > 0 && ($CardSlots.cardsOnPlay) <= 11 && $UI.day <= 10:
		var turno = "Turno " + str($UI.day)  # Esto construye "Turno 1")
		var dealed = cardsList.pop_at(randi_range(0, len(cardsList)-1))
		var card_data = St_GlobalSignals.card_data[dealed]
		# Crear una nueva instancia de la carta
		var new_card = card_scene.instantiate()
		St_GlobalSignals.Puntaje[turno]["CartasIngresadas"].append(dealed)
		new_card.ID = dealed
		# Datos a agregar
		var nueva_solucion = "Solucion X"  # Puede ser cualquier tipo de dato: string, int, etc.
		#new_card.Imagen = card_data["cardImage"]
		new_card.cardName = card_data["cardName"]
		new_card.cost = card_data["cost"]
		new_card.description = card_data["description"]
		new_card.type = card_data["type"]
		new_card.Imagen = card_data["cardImage"]
		# Posicionar la carta en el tablero
		add_child(new_card)
		new_card.onGame = true
		$CardSlots.card_Entered(new_card)
		new_card.placing = "hand"
		new_card.add_to_group("solution_cards")
		if len(cardsList) == 1:
			$Deck/CardCount.text = "%d carta"%(len(cardsList))
		else:
			$Deck/CardCount.text = "%d cartas"%(len(cardsList))

func chooseEnemy():
	if  len(enemycardsList) > 0 && ($EnemySlots.cardsOnPlay) <= 4 && $UI.day <= 10:
		var turno = "Turno " + str($UI.day)  # Esto construye "Turno 1")
		var dealed = enemycardsList.pop_at(randi_range(0, len(enemycardsList)-1))
		var card_data = St_GlobalSignals.enemy_card_data[dealed]
		# Crear una nueva instancia de la carta
		var new_card = card_scene.instantiate()
		St_GlobalSignals.Puntaje[turno]["StakeHolderIngresados"].append(dealed)
		new_card.ID = dealed
		new_card.cardName = card_data["cardName"]
		new_card.cost = card_data["cost"]
		new_card.description = card_data["description"]
		new_card.type = card_data["type"]
		new_card.Imagen = card_data["cardImage"]
		# Posicionar la carta en el tablero
		add_child(new_card)
		new_card.onGame = true
		$EnemySlots.card_Entered(new_card)
		new_card.placing = "hand"
		# Añadir la carta al grupo 'cards'
		new_card.add_to_group("cards")
		
func on_PassTurnButtonPressed(): #Trigger para repartir carta
	$Mensaje.visible = false
	$Tablero.modulate = Color(1, 1, 1, 0.384)
	# Revisa todas las cartas generadas y verifica su tipo
	if $UI.day <= 10:
		var CartaUrgente = false
		for card in get_tree().get_nodes_in_group("cards"):
			if card.cost == 2:
				$Tablero.modulate = Color(1, 0.478, 0.41, 0.384)
				CartaUrgente = true
			if card.cost == 1 && card.M09_act != true:
				#para Debug, comentar cambiando get_tree()+break, por pass
				#pass
				get_tree().change_scene_to_file("res://Scenes/PantallaDerrota/SC_PantallaDerrota.tscn")
				break
	chooseEnemy()
	if $UI.day < 10:
		for i in range(2):
			dealCard()

func CardExited(solucion, stakeholder):
	$CardSlots.card_Exited(solucion)
	if stakeholder != null:
		$EnemySlots.card_Exited(stakeholder)

func Attack(solucion,stakeholder):
	var turno = "Turno " + str($UI.day)  # Esto construye "Turno 1")
	var ataque
	var id_carta_atacante = solucion.ID
	var card_data = St_GlobalSignals.enemy_card_data[stakeholder.ID]
	# Verifica si el ID está en el array de soluciones
	if id_carta_atacante in card_data.soluciones:
		# Acciones a realizar si la carta está en el array de soluciones
		$SolucionTotal.play()
		St_GlobalSignals.Puntaje["Puntos"]["resueltas"] += 1
		ataque = ("%s -> %s = Resuelto" %[solucion.ID, stakeholder.ID])
		St_GlobalSignals.Puntaje[turno]["Ataques"].append(ataque)
		CardExited(solucion,stakeholder)
		solucion.position = $Graveyard.position
		solucion.placing = "graveyard"
		stakeholder.queue_free()
		selectedCard= null
		cartaAtacada = null
		$Mensaje.text = "Stakeholder Satisfecho Totalmente"
		$Mensaje.visible = true
		await get_tree().create_timer(3).timeout  # Espera 2 segundos
		$Mensaje.visible = false  # Esto hará que el Label sea invisible
	
	# Verifica si el ID está en el array de parches
	elif id_carta_atacante in card_data.parches:
		# Acciones a realizar si la carta está en el array de parches
		if stakeholder.parche == 0:
			$SolucionParcial.play()
			St_GlobalSignals.Puntaje["Puntos"]["parches"] += 1
			ataque = ("%s -> %s = Parche" %[solucion.ID, stakeholder.ID])
			St_GlobalSignals.Puntaje[turno]["Ataques"].append(ataque)
			CardExited(solucion,null)
			stakeholder.parche = stakeholder.parche + 1
			solucion.position = $Graveyard.position
			solucion.placing = "graveyard"
			selectedCard = null
			cartaAtacada = null
			$Mensaje.text = "Stakeholder Satisfecho Parcialmente"
			$Mensaje.visible = true
			await get_tree().create_timer(3).timeout  # Espera 2 segundos
			$Mensaje.visible = false  # Esto hará que el Label sea invisible
		elif stakeholder.parche == 1:
			$SolucionTotal.play()
			St_GlobalSignals.Puntaje["Puntos"]["parchadas"] += 1
			ataque = ("%s -> %s = Parchado" %[solucion.ID, stakeholder.ID])
			St_GlobalSignals.Puntaje[turno]["Ataques"].append(ataque)
			CardExited(solucion,stakeholder)
			solucion.position = $Graveyard.position
			solucion.placing = "graveyard"
			stakeholder.queue_free()
			selectedCard= null
			cartaAtacada = null
			$Mensaje.text = "Stakeholder Satisfecho Parcialmente"
			$Mensaje.visible = true
			await get_tree().create_timer(3).timeout  # Espera 2 segundos
			$Mensaje.visible = false  # Esto hará que el Label sea invisible
		

	# Verifica si el ID está en el array de no afecta
	else:
		# Acciones a realizar si la carta está en el array de no afecta
		null
		CardExited(solucion,null)
		solucion.position = $Graveyard.position
		solucion.placing = "graveyard"
		selectedCard= null
		cartaAtacada = null
		$SinEfecto.play()
		St_GlobalSignals.Puntaje["Puntos"]["incorrectas"] += 1
		ataque = ("%s -> %s = Fallo" %[solucion.ID, stakeholder.ID])
		St_GlobalSignals.Puntaje[turno]["Ataques"].append(ataque)
		$Mensaje.text = "La solución no tuvo efecto"
		$Mensaje.visible = true
		await get_tree().create_timer(3).timeout  # Espera 2 segundos
		$Mensaje.visible = false  # Esto hará que el Label sea invisible
	

func on_CardSelected(card): #Trigger para cuando una carta es seleccionada
	if card.placing != "graveyard":
		var turno = "Turno " + str($UI.day)  # Esto construye "Turno 1")
		var ataque
		for cartas in get_tree().get_nodes_in_group("solution_cards"):
			cartas.get_node("CardSprite/Outline").visible = false

		if card.ID in ["M02","M05","M08","M09","M10","M12","M13"]:
			if  $UI.budgetCurrent >= card.cost:
				$UI.budgetCurrent = $UI.budgetCurrent - card.cost
				St_EffectsHandler.executeEffect(card,null)
				$Mitigacion.play()
				St_GlobalSignals.Puntaje["Puntos"]["mitigaciones"] += 1
				card.position = $Graveyard.position
				$CardSlots.card_Exited(card)
				for cartas in get_tree().get_nodes_in_group("solution_cards"):
						if cartas.placing == "graveyard":
							cartas.en_graveyard()
				card.placing = "graveyard"
				if card.ID != "M12":
					ataque = ("%s" %[card.ID])
					St_GlobalSignals.Puntaje[turno]["MitigacionesJugadas"].append(ataque)
				selectedCard= null
			else:
				$Mensaje.text = "No hay presupuesto suficiente"
				$Mensaje.visible = true
				await get_tree().create_timer(3).timeout  # Espera 2 segundos
				$Mensaje.visible = false  # Esto hará que el Label sea invisible

		elif (card.type) == "Solucion" && (selectedCard) != null && selectedCard.ID in ["M03","M06"]:
			if  $UI.budgetCurrent >= selectedCard.cost:
				$UI.budgetCurrent = $UI.budgetCurrent - selectedCard.cost
				St_EffectsHandler.executeEffect(selectedCard,card)
				$Mitigacion.play()
				St_GlobalSignals.Puntaje["Puntos"]["mitigaciones"] += 1
				selectedCard.position = $Graveyard.position
				$CardSlots.card_Exited(selectedCard)
				for cartas in get_tree().get_nodes_in_group("solution_cards"):
						if cartas.placing == "graveyard":
							cartas.en_graveyard()
				selectedCard.placing = "graveyard"
				ataque = ("%s -> %s" %[selectedCard.ID, card.ID])
				St_GlobalSignals.Puntaje[turno]["MitigacionesJugadas"].append(ataque)
				selectedCard= null
			else:
				$Mensaje.text = "No hay presupuesto suficiente"
				$Mensaje.visible = true
				await get_tree().create_timer(3).timeout  # Espera 2 segundos
				$Mensaje.visible = false  # Esto hará que el Label sea invisible

		elif (card.type) == "Solucion" or (card.type) == "Mitigacion":
			card.get_node("CardSprite/Outline").visible = true
			selectedCard = card

		elif (card.type) == "Stakeholder":
			cartaAtacada = card
			if (selectedCard) != null && $UI.budgetCurrent >= selectedCard.cost && selectedCard.ID not in ["M03","M06"]:
				$UI.budgetCurrent = $UI.budgetCurrent - selectedCard.cost
				if (selectedCard.type) == "Mitigacion":
					St_EffectsHandler.executeEffect(selectedCard,card)
					$Mitigacion.play()
					St_GlobalSignals.Puntaje["Puntos"]["mitigaciones"] += 1
					selectedCard.position = $Graveyard.position
					$CardSlots.card_Exited(selectedCard)
					for cartas in get_tree().get_nodes_in_group("solution_cards"):
							if cartas.placing == "graveyard":
								cartas.en_graveyard()
					selectedCard.placing = "graveyard"
					ataque = ("%s -> %s" %[selectedCard.ID, card.ID])
					St_GlobalSignals.Puntaje[turno]["MitigacionesJugadas"].append(ataque)
					selectedCard= null
				else:
					for cartas in get_tree().get_nodes_in_group("solution_cards"):
						if cartas.placing == "graveyard":
							cartas.en_graveyard()
					Attack(selectedCard,cartaAtacada)
			else:
				$Mensaje.text = "No hay presupuesto suficiente"
				$Mensaje.visible = true
				await get_tree().create_timer(3).timeout  # Espera 2 segundos
				$Mensaje.visible = false  # Esto hará que el Label sea invisible
