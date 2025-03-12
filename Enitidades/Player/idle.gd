class_name Idle
extends PlayerState

func _enter(previous_state: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0

func _update(_delta: float) -> void:
	if player.movement_inpus.x != 0.0 and player.is_on_floor():
		transition_to.emit(WALK)
	elif player.is_jumps_pressed:
		transition_to.emit(JUMP)

func _physics_update(_delta: float) -> void:
	handle_gravity(_delta)
	
	player.move_and_slide()

func handle_gravity(_delta: float) -> void:
	player.velocity.y -= player.gravedad * _delta
	player.velocity.y = max(player.velocity.y, -player.gravedad * 100.0)
