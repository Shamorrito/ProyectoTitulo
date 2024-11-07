extends Node
var numeroPagina: int = 1
var maxPagina: int = 6  # Número de páginas

var paginas: Array

func _ready():
	# Asigna los Labels a la lista de páginas
	paginas = [
		$Ayuda_Pagina1,
		$Ayuda_Pagina2,
		$Ayuda_Pagina3,
		$Ayuda_Pagina4,
		$Ayuda_Pagina5,
		$Ayuda_Pagina6
	]
	
	$Ayuda_Pagina2/Ejemplo_Normal/Description.visible = false
	$Ayuda_Pagina3/Ejemplo_Parcial/Description.visible = false
	actualizarPagina()  # Mostrar la página inicial

func _on_btn_prev_page_pressed():
	if numeroPagina > 1:
		numeroPagina -= 1
		actualizarPagina()

func _on_btn_next_page_pressed():
	if numeroPagina < maxPagina:
		numeroPagina += 1
		actualizarPagina()

func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen/SC_TitleScreen.tscn")

# Función para mostrar la página correspondiente y ocultar el resto
func actualizarPagina():
	# Actualiza las páginas
	for i in range(paginas.size()):
		if i == (numeroPagina - 1):  # Mostrar la página actual
			paginas[i].visible = true
		else:
			paginas[i].visible = false
	
	# Actualiza la visibilidad de los botones
	$BtnPrevPage.visible = numeroPagina > 1
	$BtnNextPage.visible = numeroPagina < maxPagina

func _on_hitbox_mouse_entered():
	$Ayuda_Pagina2/Ejemplo_Normal/Description.visible = true
	$Ayuda_Pagina3/Ejemplo_Parcial/Description.visible = true
func _on_hitbox_mouse_exited():
	$Ayuda_Pagina2/Ejemplo_Normal/Description.visible = false
	$Ayuda_Pagina3/Ejemplo_Parcial/Description.visible = false
