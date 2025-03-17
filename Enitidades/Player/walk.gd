class_name Walk
extends PlayerState

func _enter(previous_state: String, data := {}) -> void:
	anim.set("parameters/conditions/isWalking", true)
	anim.set("parameters/conditions/isIdle", false)
	anim.set("parameters/conditions/inFloor", true)
	anim.set("parameters/conditions/isFalling", false)

func _update(_delta: float) -> void:
	if player.velocity.x == 0.0 and player.movement_inpus.x == 0.0:
		transition_to.emit(IDLE)
	elif player.is_jumps_pressed:
		transition_to.emit(JUMP)

func _physics_update(_delta: float) -> void:
	handle_movement(_delta)
	handle_gravity(_delta)
	
	player.move_and_slide()

func handle_movement(_delta: float) -> void:
	var target_speed : float = player.movement_inpus.x * player.velocidad
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.aceleracion * _delta)

func handle_gravity(_delta: float) -> void:
	player.velocity.y -= player.gravedad * _delta
	player.velocity.y = max(player.velocity.y, -player.max_garvedad)
