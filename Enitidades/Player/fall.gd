class_name Fall
extends PlayerState

func _enter(previous_state: String, data := {}) -> void:
	if player.jumps_count == 0:
		player.coyote_timer.start(player.coyote_time)

func _update(_delta: float) -> void:
	if player.is_on_floor() and player.velocity.x == 0.0:
		transition_to.emit(IDLE)
	elif player.is_on_floor() and player.velocity.x != 0.0:
		transition_to.emit(WALK)
	elif not player.jump_timer.is_stopped() and player.in_right_wall:
		transition_to.emit(JUMP, {"wall_jump_velocity": -player.velocidad})
	elif not player.jump_timer.is_stopped() and player.in_left_wall:
		transition_to.emit(JUMP, {"wall_jump_velocity": player.velocidad})

func _physics_update(_delta: float) -> void:
	handle_movement(_delta)
	handle_gravity(_delta)
	
	player.move_and_slide()

func handle_movement(_delta: float) -> void:
	var target_speed : float = player.movement_inpus.x * player.velocidad
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.aceleracion_aerea * _delta)

func handle_gravity(_delta: float) -> void:
	var actual_gravity = player.gravedad
	if player.sliding_wall:
		actual_gravity = player.gravedad * 0.1
	player.velocity.y -= actual_gravity * _delta
	player.velocity.y = max(player.velocity.y, -player.max_garvedad)
