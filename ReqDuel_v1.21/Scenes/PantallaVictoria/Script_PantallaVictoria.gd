extends Node2D

var resueltas: int
var parches: int
var incorrectas: int
var parchadas: int
var sinSolucion: int
var diasTranscurridos: int
var puntaje: int
var mitigaciones: int
var time = Time.get_datetime_dict_from_system()
var Fecha = ("%s/%s/%s" %[time.day, time.month, time.year])

func _ready():
	$SonidoVictoria.play()
	resueltas = St_GlobalSignals.Puntaje["Puntos"]["resueltas"]
	parches = St_GlobalSignals.Puntaje["Puntos"]["parches"]
	incorrectas = St_GlobalSignals.Puntaje["Puntos"]["incorrectas"]
	parchadas = St_GlobalSignals.Puntaje["Puntos"]["parchadas"]
	sinSolucion = St_GlobalSignals.Puntaje["Puntos"]["sinSolucion"]
	mitigaciones = St_GlobalSignals.Puntaje["Puntos"]["mitigaciones"]
	puntaje = (parches*100+resueltas*300+parchadas*100-incorrectas*50+1000)
	
	$BoxPuntaje/UsuariosSatisfechos.text = "Usuarios Satisfechos: %d" %(resueltas+parchadas)	
	$BoxPuntaje/CartasUtilizadas.text = "Cartas Utilizadas: %d" %(parches+resueltas+parchadas+incorrectas)
	$BoxPuntaje/CartasSinEfecto.text = "Cartas Sin Efecto: %d" %incorrectas
	$BoxPuntaje/SolucionesParciales.text = "Soluciones Parciales: %d" %(parches+parchadas)
	$BoxPuntaje/SolucionesTotales.text = "Soluciones Inmediatas: %d" %resueltas
	$BoxPuntaje/MitigacionesUsadas.text = "Mitigaciones Usadas: %d" %mitigaciones
	
	$PuntajeTotal.text = "Puntaje Total: %d" %puntaje
	export_puntaje_to_csv()


func _on_btn_victoria_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen/SC_TitleScreen.tscn")

func export_puntaje_to_csv():
	var file_path = "user://Puntaje.csv"
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)

	if file == null:
		file = FileAccess.open(file_path, FileAccess.WRITE)
	
	# Verifica si el archivo está vacío y escribe el encabezado solo si no tiene datos
	if file.get_length() == 0:
		file.store_line("Turno;StakeHolderIngresados;CartasIngresadas;Ataques;MitigacionesJugadas")  # Encabezado de columnas

	file.seek_end()  # Coloca el cursor al final del archivo


	# Recorre todos los turnos en el diccionario Puntaje
	for turno in St_GlobalSignals.Puntaje.keys():
		if turno.begins_with("Turno"):  # Asegura que estamos recorriendo los turnos
			var turno_data = St_GlobalSignals.Puntaje[turno]
			var stakeholders = turno_data["StakeHolderIngresados"]
			var cartas = turno_data["CartasIngresadas"]
			var ataques = turno_data["Ataques"]
			var mitigacionesJugadas = turno_data["MitigacionesJugadas"]
			var linea_datos = "%s;%s;%s;%s;%s" % [
				turno, stakeholders, cartas, ataques, mitigacionesJugadas
			]
			var linea_datos_extra = ""

			match turno:
				"Turno 1":
					linea_datos_extra = ";;Nombre;%s"%St_GlobalSignals.NombreUsuario
				"Turno 2":
					linea_datos_extra = ";;Fecha;%s"%[Fecha]
				"Turno 3":
					linea_datos_extra = ";;Dias Transcurridos;%s"%[diasTranscurridos]	
				"Turno 4":
					linea_datos_extra = ";;Parchadas;%s"%[parchadas]	
				"Turno 5":
					linea_datos_extra = ";;Incorrectas;%s"%[incorrectas]	
				"Turno 6":
					linea_datos_extra = ";;Sin Solucion;%s"%[sinSolucion]	
				"Turno 7":
					linea_datos_extra = ";;Perfectas;%s"%[resueltas]	
				"Turno 8":
					linea_datos_extra = ";;Mitigaciones;%s"%[mitigaciones]	
				"Turno 9":
					linea_datos_extra = ";;Parches;%s"%[parches]	
				"Turno 10":
					linea_datos_extra = ";;Puntaje;%s"%[puntaje]	

			linea_datos = "%s%s"%[linea_datos , linea_datos_extra]
			file.store_line(linea_datos)
	file.store_line("")  # Añade una línea vacía al final
	file.close()  # Cierra el archivo
