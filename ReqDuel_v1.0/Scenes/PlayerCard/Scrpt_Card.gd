extends Node2D

#Información de la carta relevante en el juego
@export var ID: String
@export var cardName: String
@export_range(0,6) var cost: int
@export var type: String
@export_multiline var description: String
@export var Imagen : String
@export var image_texture_rect : TextureRect

#información de monitoreo de la carta
var placing = "deck"
var posOnCard: Vector2 #posición relativa del mouse sobre la carta
var selected: bool = false
var onGame: bool = false
var parche: int = 0
var newTexture = load("res://Assets/IMG_Templates/Template_Solucion.png")
var textureParche = load("res://Assets/IMG_Templates/Template_Stakeholder_P.png")
var textureMitigacion = load("res://Assets/IMG_Templates/Template_Mitigacion.png")
var M09_act = false
var M14_act = false
var M13_act = false

# Actualiza la flecha para que siga el ratón mientras se selecciona el objetivo
func _ready():
	# En el script de la carta atacante
	var Imagen_path = Imagen
	var texture = load(Imagen_path)
	if image_texture_rect :
		if texture :
			image_texture_rect.texture = texture
		else :
			pass
	else :
		pass
	change_texture(newTexture)
	
	St_GlobalSignals.PassTurnButtonPressed.connect(on_PassTurnButtonPressed)
	$CardSprite/Name.text = cardName
	$CardSprite/Description.text = description
	$CardSprite/Description.visible = false

func _process(_delta):
	if (type == "Stakeholder"):
		$CardSprite/Cost.text = "%d"%cost
	else :
		$CardSprite/Cost.text = "$%d"%cost
	if parche == 1:
		$CardSprite.texture = textureParche

func _on_area_card_input_event(_viewport, event, _shape_idx): #detección de click sobre la carta para seleccionarla
	if placing != "waiting" and M13_act == false and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			St_GlobalSignals.CardSelected.emit(self)
		else:
			selected = false
			get_parent().get_node("CardSlots").reposition()
	elif placing == "waiting" and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			St_GlobalSignals.CardWaiting.emit(self)
	
func _on_area_card_mouse_entered(): #detección de mouse hovering hacia la carta
	if placing != "graveyard" and M13_act == false:
		$CardSprite/Description.visible = true

func _on_area_card_mouse_exited(): #detección de mouse hovering fuera de la carta
	if M13_act == false:
		$CardSprite/Description.visible = false
	
func on_PassTurnButtonPressed(): #Trigger para repartir carta
	if M14_act:
		cost = cost + 1
		M14_act = false
	if (type == "Stakeholder"):
		if (M09_act):
			$CardSprite/Cost.text = "%d"%cost
			M09_act = false
		else :
			cost = cost -1
			$CardSprite/Cost.text = "%d"%cost

func change_texture(nuevaTextura:Texture2D):
	if type == "Solucion":
		$CardSprite.texture = nuevaTextura
	if type == "Mitigacion":
		$CardSprite.texture = textureMitigacion

func en_graveyard():
	$CardSprite/Name.visible = false
	$CardSprite/Cost.visible = false
