extends Node

signal PassTurnButtonPressed
signal CardSelected(card: Node2D)
signal CardWaiting(card: Node2D)
var NombreUsuario: String = ""

var Puntaje = {
	"Turno 1": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 2": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 3": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 4": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 5": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 6": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 7": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 8": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 9": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 10": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Puntos": {
		"resueltas": 0, 
		"parches": 0, 
		"incorrectas": 0, 
		"parchadas": 0, 
		"sinSolucion": 0,
		"diasTranscurridos": 0,
		"mitigaciones": 0,
		},
	}

var card_data = {
	"A01": {"cardImage": "res://Assets/IMG/Respuesta/A01.png", "cardName": "Aumento de Frecuencia de Trenes", "cost": 2, "type": "Solucion", "description": "Aumento en la frecuencia de los trenes durante las horas peak."},
	"A02": {"cardImage": "res://Assets/IMG/Respuesta/A02.png", "cardName": "Mejora de Señalización", "cost": 3, "type": "Solucion", "description": "Actualiza la señalización en todas las estaciones con información clara y detallada sobre salidas, conexiones y horarios."},
	"A03": {"cardImage": "res://Assets/IMG/Respuesta/A03.png", "cardName": "Mejora de Infraestructura de Estaciones", "cost": 4, "type": "Solucion", "description": "Moderniza señalizaciones, accesos y conexiones, ademas de proporcionar rampas y elevadores en las estaciones que lo necesitan."},
	"A04": {"cardImage": "res://Assets/IMG/Respuesta/A04.png", "cardName": "Implementación de Información Multilingüe", "cost": 2, "type": "Solucion", "description": "Implementa señalización e información en múltiples idiomas."},
	"A05": {"cardImage": "res://Assets/IMG/Respuesta/A05.png", "cardName": "Provisión de Herramientas Modernas", "cost": 1, "type": "Solucion", "description": "Proporciona al personal de mantenimiento herramientas y equipos modernos mas adecuados para acelerar las reparaciones y el mantenimiento."},
	"A06": {"cardImage": "res://Assets/IMG/Respuesta/A06.png", "cardName": "Programas de capacitación continua", "cost": 2, "type": "Solucion", "description": "Implementa programas de capacitación continua para el personal de las estaciones."},
	"A07": {"cardImage": "res://Assets/IMG/Respuesta/A07.png", "cardName": "Instalación de Cámaras de Vigilancia", "cost": 1, "type": "Solucion", "description": "Instalación de cámaras de vigilancia en puntos clave de las estaciones de metro."},
	"A08": {"cardImage": "res://Assets/IMG/Respuesta/A08.png", "cardName": "Descuentos Estudiantiles ", "cost": 1, "type": "Solucion", "description": "Introduce un sistema de descuentos y tarifas reducidas específicamente para estudiantes."},
	"A09": {"cardImage": "res://Assets/IMG/Respuesta/A09.png", "cardName": "Implementar Sistema de Gestión de Flota", "cost": 2, "type": "Solucion", "description": "Sistema de gestión de flota actualizado que incluye tecnologías avanzadas para la supervisión y coordinación en tiempo real."},
	"A10": {"cardImage": "res://Assets/IMG/Respuesta/A10.png", "cardName": "Implementacion de Mapas Interactivos", "cost": 2, "type": "Solucion", "description": "Implementa mapas interactivos en las estaciones."},
	"A11": {"cardImage": "res://Assets/IMG/Respuesta/A11.png", "cardName": "Reorganizacion de los horarios de trabajo", "cost": 3, "type": "Solucion", "description": "Reestructura los horarios de los trabajadores"},
	"A12": {"cardImage": "res://Assets/IMG/Respuesta/A12.png", "cardName": "Aplicación del Metro", "cost": 2, "type": "Solucion", "description": "Implementa una aplicación que otorga tarifas mas bajas, además de otorgar informacion detallada sobre cuando empieza y termina la hora peak"},
	"A13": {"cardImage": "res://Assets/IMG/Respuesta/A13.png", "cardName": "Ajuste de los horarios de los trenes", "cost": 1, "type": "Solucion", "description": "Ajuste de los horarios de salida de los trenes "},
	"A14": {"cardImage": "res://Assets/IMG/Respuesta/A14.png", "cardName": "Carta Gantt", "cost": 3, "type": "Solucion", "description": "Estructura un plan de Acción para el futuro del personal"},
	"A15": {"cardImage": "res://Assets/IMG/Respuesta/A15.png", "cardName": "Mejora de la Red Wi-Fi", "cost": 1, "type": "Solucion", "description": "Amplía y mejora la cobertura de la red Wi-Fi en todas las estaciones y trenes"},
	"A16": {"cardImage": "res://Assets/IMG/Respuesta/A16.png", "cardName": "Campaña de Sensibilización", "cost": 1, "type": "Solucion", "description": "Lanza una campaña de sensibilización sobre el respeto y el cuidado de las instalaciones"},
	"A17": {"cardImage": "res://Assets/IMG/Respuesta/A17.png", "cardName": "Introducción de Pagina Web", "cost": 2, "type": "Solucion", "description": "Desarrolla una pagina web que proporciona información en tiempo real sobre horarios, retrasos, mapas y noticias del metro"},
	"A18": {"cardImage": "res://Assets/IMG/Respuesta/A18.png", "cardName": "Servicios de Atención al Cliente", "cost": 3, "type": "Solucion", "description": "Implementa y mejora los servicios de atención al cliente en todas las estaciones"},
	"A19": {"cardImage": "res://Assets/IMG/Respuesta/A19.png", "cardName": "Refuerzo personal de Limpieza y Mantenimiento", "cost": 2, "type": "Solucion", "description": "Incrementa la frecuencia y calidad de la limpieza y el mantenimiento en las estaciones y trenes"},
	"A20": {"cardImage": "res://Assets/IMG/Respuesta/A20.png", "cardName": "Mejora de Iluminación", "cost": 2, "type": "Solucion", "description": "Instala y mejora la iluminación en todas las estaciones y áreas circundantes"},
	"A21": {"cardImage": "res://Assets/IMG/Respuesta/A21.png", "cardName": "Integración de Sistemas de Pago", "cost": 3, "type": "Solucion", "description": "Implementa un sistema de pago integrado que acepta tarjetas de crédito, débito y aplicaciones móviles"},
	"A22": {"cardImage": "res://Assets/IMG/Respuesta/A22.png", "cardName": "Expansión de Áreas de Espera", "cost": 3, "type": "Solucion", "description": "Amplía y mejora las áreas de espera en las estaciones"},
	"A23": {"cardImage": "res://Assets/IMG/Respuesta/A23.png", "cardName": "Programas de Incentivos para Usuarios Frecuentes", "cost": 3, "type": "Solucion", "description": "Introduce programas de incentivos y recompensas para usuarios frecuentes, como descuentos y beneficios exclusivos"},
	"A24": {"cardImage": "res://Assets/IMG/Respuesta/A24.png", "cardName": "Mejoras en la Accesibilidad Digital", "cost": 3, "type": "Solucion", "description": "Mejora la accesibilidad de la página web y la aplicación móvil del metro"},
	"M01": {"cardImage": "res://Assets/IMG/Mitigacion/M01.png", "cardName": "Extension de Plazo", "cost": 4, "type": "Mitigacion", "description": "Devuelve una carta de Stakeholder a su mazo"},
	"M02": {"cardImage": "res://Assets/IMG/Mitigacion/M02.png", "cardName": "Subsidio", "cost": 3, "type": "Mitigacion", "description": "Roba dos cartas"},
	"M03": {"cardImage": "res://Assets/IMG/Mitigacion/M03.png", "cardName": "Reestructuración", "cost": 1, "type": "Mitigacion", "description": "Descarta una carta de solución, roba una carta"},
	"M04": {"cardImage": "res://Assets/IMG/Mitigacion/M04.png", "cardName": "Feriado", "cost": 3, "type": "Mitigacion", "description": "Aumenta la paciencia de un stakeholder por 2 turnos."},
	"M05": {"cardImage": "res://Assets/IMG/Mitigacion/M05.png", "cardName": "Préstamo", "cost": 0, "type": "Mitigacion", "description": "Agrega $2 de presupuesto para usar durante el turno"},
	"M06": {"cardImage": "res://Assets/IMG/Mitigacion/M06.png", "cardName": "Bono", "cost": 0, "type": "Mitigacion", "description": "Reduce el costo de una solución en $1."},
	"M07": {"cardImage": "res://Assets/IMG/Mitigacion/M07.png", "cardName": "Posponer", "cost": 1, "type": "Mitigacion", "description": "Aumenta la paciencia de un Stakeholder en 1 punto."},
	"M08": {"cardImage": "res://Assets/IMG/Mitigacion/M08.png", "cardName": "Capacitación Rápida", "cost": 4, "type": "Mitigacion", "description": "Aumenta la paciencia de todos los Stakeholders activos en 1 punto."},
	"M09": {"cardImage": "res://Assets/IMG/Mitigacion/M09.png", "cardName": "Refuerzo Temporal", "cost": 5, "type": "Mitigacion", "description": "Añade un turno adicional antes de quese reduzca la paciencia de todos los Stakeholders actuales."},
	"M10": {"cardImage": "res://Assets/IMG/Mitigacion/M10.png", "cardName": "Fondos Extraordinarios", "cost": 3, "type": "Mitigacion", "description": "Aumenta el presupuesto disponible para el siguiente turno en $3."},
	"M11": {"cardImage": "res://Assets/IMG/Mitigacion/M12.png", "cardName": "Iniciativa de Comunidad", "cost": 2, "type": "Mitigacion", "description": "Satisface parcialmente un stakeholder a elección."},
	"M12": {"cardImage": "res://Assets/IMG/Mitigacion/M13.png", "cardName": "Segunda Opcion", "cost": 5, "type": "Mitigacion", "description": "Saca 3 cartas de solución, 1 de las cartas es una solución inmediata a un stakeholder en juego."},
	"M13": {"cardImage": "res://Assets/IMG/Mitigacion/M14.png", "cardName": "Cotización", "cost": 3, "type": "Mitigacion", "description": "Reduce el costo de todas las soluciones durante este turno en $1."}
}
var enemy_card_data = {
	"Q01": {
		"cardImage": "res://Assets/IMG/Pregunta/Q01.png",
		"cardName": "Usuario Regular", 
		"cost": 2, 
		"type": "Stakeholder", 
		"description": "Viajar en hora peak es insoportable, todos los trenes llenos.",
		"soluciones": ["A01", "A09", "A13"],
		"parches": ["A03", "A12", "A17", "A18", "A21", "A22", "A23", "A24"],
		"noafecta": ["A02", "A04", "A05", "A06", "A07", "A08", "A10", "A11", "A14", "A15", "A16", "A19", "A20", "A23", "A24"]
	},
	"Q02": {
		"cardImage": "res://Assets/IMG/Pregunta/Q02.png",
		"cardName": "Usuario Ocasional", 
		"cost": 2, 
		"type": "Stakeholder", 
		"description": "Me pierdo mucho en las estaciones, los carteles me llevan a cualquier parte y me demoro mucho en encontrar las salidas o las combinaciones.",
		"soluciones": ["A02", "A03", "A10"],
		"parches": ["A12", "A15", "A17", "A18", "A20", "A21", "A22", "A23", "A24"],
		"noafecta": ["A01", "A04", "A05", "A06", "A07", "A08", "A09", "A11", "A13", "A14", "A16"]
	},
	"Q03": {
		"cardImage": "res://Assets/IMG/Pregunta/Q03.png",
		"cardName": "Usuario con Movilidad Reducida", 
		"cost": 3, 
		"type": "Stakeholder", 
		"description": "Hay estaciones en las que no tengo como entrar porque no hay ascensores ni rampas, y muchas veces ni siquiera hay personal para ayudarme.",
		"soluciones": ["A03"],
		"parches": ["A04", "A05", "A11", "A12", "A18", "A20", "A21", "A22", "A23", "A24"],
		"noafecta": ["A01", "A02", "A05", "A06", "A07", "A08", "A09", "A10", "A13", "A15", "A16", "A17", "A19"]
	},
	"Q04": {
		"cardImage": "res://Assets/IMG/Pregunta/Q04.png",
		"cardName": "Turista", 
		"cost": 2, 
		"type": "Stakeholder", 
		"description": "Que frustrante es andar en metro en este pais, la información en las estaciones y en los trenes está solo en español, asi no me puedo movilizar.",
		"soluciones": ["A04"],
		"parches": ["A02", "A03", "A10", "A12", "A17", "A18", "A20", "A21", "A22", "A23", "A24"],
		"noafecta": ["A01", "A05", "A06", "A07", "A08", "A09", "A11", "A13", "A14", "A15", "A16", "A19"]
	},
	"Q05": {
		"cardImage": "res://Assets/IMG/Pregunta/Q05.png",
		"cardName": "Estudiante", 
		"cost": 4, 
		"type": "Stakeholder", 
		"description": "El metro es muy costoso para nosotros los estudiantes, es una carga financiera que no me puedo permitir.",
		"soluciones": ["A08"],
		"parches": ["A12", "A18", "A21", "A22", "A23", "A24"],
		"noafecta": ["A01", "A02", "A03", "A04", "A05", "A06", "A07", "A09", "A10", "A11", "A13", "A14", "A15", "A16", "A17", "A19", "A20"]
	},
	"Q06": {
		"cardImage": "res://Assets/IMG/Pregunta/Q06.png",
		"cardName": "Personal de Mantenimiento", 
		"cost": 3, 
		"type": "Stakeholder", 
		"description": "Tenemos demasiado trabajo, y como seguimos utilizando las mismas herramientas y equipo de hace años, no podemos hacer nuestro trabajo a tiempo y bien.",
		"soluciones": ["A05", "A19"],
		"parches": ["A06", "A11", "A16", "A14"],
		"noafecta": ["A01", "A02", "A03", "A04", "A07", "A08", "A09", "A10", "A12", "A13", "A15", "A17", "A18", "A20", "A21", "A22", "A23", "A24"]
	},
	"Q07": {
		"cardImage": "res://Assets/IMG/Pregunta/Q07.png",
		"cardName": "Operador de Estación", 
		"cost": 3, 
		"type": "Stakeholder", 
		"description": "Estoy preocupado porque la falta de capacitación continua está afectando la calidad del servicio y la eficiencia del personal.",
		"soluciones": ["A05", "A06", "A09"],
		"parches": ["A01", "A11", "A14", "A16"],
		"noafecta": ["A02", "A03", "A04", "A07", "A08", "A10", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23", "A24"]
	},
	"Q08": {
		"cardImage": "res://Assets/IMG/Pregunta/Q08.png",
		"cardName": "Jefe de Seguridad", 
		"cost": 5, 
		"type": "Stakeholder", 
		"description": "Cada día hay más delincuencia en el metro, y no podemos hacer nada que nos ayude a encontrar a los responsables.",
		"soluciones": ["A07"],
		"parches": ["A11", "A14", "A16", "A20"],
		"noafecta": ["A01", "A02", "A03", "A04", "A05", "A06", "A08", "A09", "A10", "A12", "A13", "A15", "A16", "A17", "A18", "A19", "A21", "A22", "A23", "A24"]
	},
	"Q09": {
		"cardImage": "res://Assets/IMG/Pregunta/Q09.png",
		"cardName": "Conductor del Metro", 
		"cost": 5, 
		"type": "Stakeholder", 
		"description": "Muchas veces no logro entender lo que me dicen desde el centro de control, o se corta en mitad de un mensaje, y las señalizaciones no se entienden bien.",
		"soluciones": ["A09"],
		"parches": ["A11", "A14", "A15", "A16"],
		"noafecta": ["A02", "A03", "A04", "A05", "A06", "A07", "A08", "A10", "A12", "A13", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23", "A23", "A24"]
	},
	"Q10": {
		"cardImage": "res://Assets/IMG/Pregunta/Q10.png",
		"cardName": "Dueño de Local", 
		"cost": 4, 
		"type": "Stakeholder", 
		"description": "Recibo poco apoyo de parte del Metro para hacer crecer mi negocio dentro de la estación.",
		"soluciones": ["A21", "A23"],
		"parches": ["A02", "A11", "A14", "A16", "A19", "A20"],
		"noafecta": ["A01", "A04", "A05", "A06", "A07", "A08", "A09", "A10", "A12", "A13", "A15", "A16", "A17", "A18", "A22", "A24"]
	}
}

func reset_puntajes():
	Puntaje = {
	"Turno 1": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 2": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 3": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 4": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Turno 5": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 6": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 7": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 8": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 9": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
		"Turno 10": {
		"StakeHolderIngresados":[],
		"CartasIngresadas": [], 
		"Ataques": [], 
		"MitigacionesJugadas": [],
		},
	"Puntos": {
		"resueltas": 0, 
		"parches": 0, 
		"incorrectas": 0, 
		"parchadas": 0, 
		"sinSolucion": 0,
		"diasTranscurridos": 0,
		"mitigaciones": 0,
		},
	}
