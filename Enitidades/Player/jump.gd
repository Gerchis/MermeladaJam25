class_name Jump
extends PlayerState

func _enter(previous_state: String, data := {}) -> void:
	if not player.jump_timer.is_stopped():
		player.jump_timer.stop()
	player.jump_cooldown.start()
	if data.has("wall_jump_velocity"):
		player.velocity.x = data["wall_jump_velocity"]
		player.in_left_wall = false
		player.in_right_wall = false
	else:
		player.jumps_count += 1
	
	player.velocity.y = player.fureza_salto
	
	anim.set("parameters/conditions/isWalking", false)
	anim.set("parameters/conditions/isIdle", false)
	anim.set("parameters/conditions/inFloor", false)
	anim.set("parameters/conditions/isFalling", true)
	
	player.audio_pj.stream = player.SALTO_PERSONAJE_001
	player.audio_pj.play()

func _update(_delta: float) -> void:
	#if player.is_on_floor() and player.velocity.x == 0.0:
		#transition_to.emit(IDLE)
	#if player.is_on_floor() and player.velocity.x != 0.0:
		#transition_to.emit(WALK)
	if player.velocity.y <= 0.0:
		transition_to.emit(FALL)

func _physics_update(_delta: float) -> void:
	handle_movement(_delta)
	handle_gravity(_delta)
	handle_jump_release()
	
	player.move_and_slide()

func handle_movement(_delta: float) -> void:
	var target_speed : float = player.movement_inpus.x * player.velocidad
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.aceleracion_aerea * _delta)

func handle_gravity(_delta: float) -> void:
	player.velocity.y -= player.gravedad * _delta
	player.velocity.y = max(player.velocity.y, -player.max_garvedad)

func handle_jump_release() -> void:
	if Input.is_action_just_released("jump") and player.velocity.y > player.fureza_salto * 0.2:
		player.velocity.y = player.fureza_salto * 0.2
