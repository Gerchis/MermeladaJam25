class_name Walk
extends PlayerState

func _physics_update(_delta: float) -> void:
	handle_movement(_delta)
	handle_gravity(_delta)
	
	player.move_and_slide()

func handle_movement(_delta: float) -> void:
	var target_speed : float = player.movement_inpus.x * player.velocidad
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.aceleracion * _delta)

func handle_gravity(_delta: float) -> void:
	player.velocity.y -= player.gravedad * _delta
	player.velocity.y = max(player.velocity.y, -player.gravedad * 100.0)
