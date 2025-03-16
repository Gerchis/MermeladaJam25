class_name PlayerBehaviour
extends CharacterBody3D

@export_category("Configuración del movimiento")
@export var velocidad : float = 20.0
@export var aceleracion : float = 400.0

@export_category("Configuración de salto")
@export var gravedad : float = 150.0
@export var max_garvedad : float = 200.0
@export var fureza_salto : float = 40.0
@export var aceleracion_aerea : float = 150.0
@export var cantidad_saltos : int = 1
@export var wall_jump_time : int = 0.1

@export_category("Configuración de inputs")
@export var input_buffer_time : float = 0.2
@export var coyote_time : float = 0.2

var movement_inpus : Vector2 = Vector2.ZERO
var jumps_count: int = 0
var is_jumps_pressed: bool:
	get:
		return not jump_timer.is_stopped() and jumps_count < cantidad_saltos and jump_cooldown.is_stopped() 

var sliding_wall: bool = false
var in_right_wall: bool = false
var in_left_wall: bool = false
var facing_dir: int = 1

@onready var jump_timer: Timer = %JumpTimer
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var right_cast: ShapeCast3D = %RightCast
@onready var left_cast: ShapeCast3D = %LeftCast
@onready var wall_jump_timer: Timer = %WallJumpTimer
@onready var model: Node3D = %Texturizado_Pretzel_Ojos_Final
@onready var jump_cooldown: Timer = %JumpCooldown

func _process(delta: float) -> void:
	handle_movement_inputs()
	handle_jump_input()
	handle_jump_count_reset()
	handle_facing()

func  _physics_process(delta: float) -> void:
	wall_check()

func handle_movement_inputs() -> void:
	movement_inpus = Input.get_vector("move_left", "move_right", "move_down", "move_up")

func handle_jump_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump_timer.start(input_buffer_time)

func handle_jump_count_reset() -> void:
	if is_on_floor() and jumps_count != 0 and jump_cooldown.is_stopped():
		jumps_count = 0

func _on_coyote_timer_timeout() -> void:
	if jumps_count == 0:
		jumps_count += 1

func wall_check() -> void:
	sliding_wall = false
	if wall_jump_timer.is_stopped() or is_on_floor():
		in_left_wall = false
		in_right_wall = false
	if is_on_wall_only() and right_cast.is_colliding() and velocity.y < 0.0:
		sliding_wall = true
		in_right_wall = true
		wall_jump_timer.start(wall_jump_time)
	elif is_on_wall_only() and left_cast.is_colliding() and velocity.y < 0.0:
		sliding_wall = true
		in_left_wall = true
		wall_jump_timer.start(wall_jump_time)

func handle_facing() -> void:
	if velocity.x != 0.0:
		facing_dir = sign(velocity.x)
	
	if model.rotation_degrees.y != 90.0 * facing_dir:
		model.rotation_degrees.y = 90.0 * facing_dir
