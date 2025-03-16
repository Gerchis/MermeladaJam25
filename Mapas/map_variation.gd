class_name MapVariation
extends Node3D

@export var dificulty_variations: Array[Node3D]
@export var sprinkles_variations: Array[Node3D]

var dificulty_index : int = 0

func _ready() -> void:
	activate_dificultiy_variations()
	decide_sprinkles()

func activate_dificultiy_variations() -> void:
	if dificulty_variations.is_empty(): return
	for i in dificulty_variations.size():
		if i < dificulty_index:
			dificulty_variations[i].show()
		else:
			dificulty_variations[i].hide()

func decide_sprinkles() -> void:
	if sprinkles_variations.is_empty(): return
	for n in sprinkles_variations:
		n.hide()
	
	sprinkles_variations.shuffle()
	sprinkles_variations[0].show()
