extends Camera3D

@export var player : PlayerBehaviour
@export var x_offset : float
@export var y_offset : float

var original_offset

func _ready() -> void:
	original_offset = player.global_position - global_position

func _process(delta: float) -> void:
	if player == null: return
	handle_horizontal_offset()
	handle_vertical_offset()


func handle_horizontal_offset():
	var horizontal_offset = player.global_position.x - (global_position.x + original_offset.x) 
	if horizontal_offset > x_offset:
		global_position.x = player.global_position.x - x_offset - original_offset.x
	
	if horizontal_offset < -x_offset:
		global_position.x = player.global_position.x + x_offset - original_offset.x

func handle_vertical_offset():
	var vertical_offset = player.global_position.y - (global_position.y + original_offset.y)
	if vertical_offset > y_offset:
		global_position.y = player.global_position.y - y_offset - original_offset.y
	
	if vertical_offset < 0.0:
		global_position.y = player.global_position.y - original_offset.y
