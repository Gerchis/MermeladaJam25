class_name PlayerBehaviour
extends CharacterBody3D

@export_category("Configuración del movimiento")
@export var velocidad : float = 20.0
@export var aceleracion : float = 500.0

@export_category("Configuración de salto")
@export var gravedad : float = 200.0
@export var fureza_salto : float = 50.0
@export var aceleracion_aerea : float = 150.0
@export var cantidad_saltos : int = 1

@export_category("Configuración de inputs")
@export var input_buffer_time : float = 0.2
@export var coyote_time : float = 0.2

var movement_inpus : Vector2 = Vector2.ZERO
var jumps_count: int = 0
var is_jumps_pressed: bool:
	get:
		return not jump_timer.is_stopped() and jumps_count < cantidad_saltos
var in_right_wall: bool = false
var in_left_wall: bool = true

@onready var jump_timer: Timer = %JumpTimer
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var right_cast: ShapeCast3D = %RightCast
@onready var left_cast: ShapeCast3D = %LeftCast

func _process(delta: float) -> void:
	handle_movement_inputs()
	handle_jump_input()
	handle_jump_count_reset()

func  _physics_process(delta: float) -> void:
	wall_check()

func handle_movement_inputs() -> void:
	movement_inpus = Input.get_vector("move_left", "move_right", "move_down", "move_up")

func handle_jump_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump_timer.start(input_buffer_time)

func handle_jump_count_reset() -> void:
	if is_on_floor() and jumps_count != 0:
		jumps_count = 0

func _on_coyote_timer_timeout() -> void:
	if jumps_count == 0:
		jumps_count += 1

func wall_check() -> void:
	in_left_wall = false
	in_right_wall = false
	if is_on_wall_only() and right_cast.is_colliding():
		in_right_wall = true
	elif is_on_wall_only() and left_cast.is_colliding():
		in_left_wall = true
