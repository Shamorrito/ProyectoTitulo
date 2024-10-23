extends Node2D

@onready var Slots = [{"slot": $Row1/Slot1, "card": null},
					{"slot": $Row1/Slot2, "card": null},
					{"slot": $Row1/Slot3, "card": null},
					{"slot": $Row1/Slot4, "card": null},
					{"slot": $Row1/Slot5, "card": null},
					{"slot": $Row1/Slot6, "card": null},
					{"slot": $Row2/Slot1, "card": null},
					{"slot": $Row2/Slot2, "card": null},
					{"slot": $Row2/Slot3, "card": null},
					{"slot": $Row2/Slot4, "card": null},
					{"slot": $Row2/Slot5, "card": null},
					{"slot": $Row2/Slot6, "card": null}]

var distance: int = 196
var cardsOnPlay: int = 0

func _ready():
	pass

func reposition(): #reposiciona las cartas nuevamente cuando los slots se mueven
	for slot in Slots:
		if slot["card"] != null:
			slot["card"].position = slot["slot"].global_position

func card_Entered(card: Node2D): #lógica para cuando una carta entra a la mano
	cardsOnPlay += 1
	
	for slot in Slots:
		if slot["card"] == null:
			slot["card"] = card
			slot["card"].position = slot["slot"].global_position
			break
	
	if cardsOnPlay <= 6:
		$Row1.position.x -= distance/2
	else:
		$Row2.position.x -= distance/2
	
	reposition()

func card_Exited(card: Node2D): #lógica para cuando una carta sale de la mano
	cardsOnPlay -= 1
	
	for slot in Slots:
		if slot["card"] == card:
			slot["card"] = null
			break
	
	if cardsOnPlay < 6:
		$Row1.position.x += distance/2
	else:
		$Row2.position.x += distance/2
	reasign()
	reposition()

func reasign(): #Reasigna los slots cuando una carta sale de uno de ellos
	var posNext
	for slot in Slots:
		posNext = Slots.find(slot) + 1
		if slot["card"] == null and posNext < 12:
			slot["card"] = Slots[posNext]["card"]
			Slots[posNext]["card"] = null

func next_Slot() -> Vector2: #retorna la posición del siguiente slot vacío
	for slot in Slots:
		if slot["card"] == null:
			return $Row1.position
	return Vector2(0,0)
