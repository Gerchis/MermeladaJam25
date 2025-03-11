class_name PlayerBehaviour
extends CharacterBody3D

@export_category("Configuración del movimiento")
@export var velocidad : float = 50.0
@export var aceleracion : float = 200.0

@export_category("Configuración de salto")
@export var gravedad : float = 200.0
@export var fureza_salto : float = 800.0

var movement_inpus : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	handle_movement_inputs()

func handle_movement_inputs() -> void:
	movement_inpus = Input.get_vector("move_left", "move_right", "move_down", "move_up")
