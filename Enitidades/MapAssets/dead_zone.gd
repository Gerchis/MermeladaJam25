extends Area3D

const DEATH_PARTICLES = preload("res://Enitidades/MapAssets/death_particles.tscn")

func _ready() -> void:
	body_entered.connect(on_body_entered)
	get_parent_node_3d().visibility_changed.connect(update_colisions)

func on_body_entered(body: Node3D):
	if not body.is_in_group("Player"): return
	
	var particles := DEATH_PARTICLES.instantiate()
	var player : PlayerBehaviour = body as PlayerBehaviour
	add_child(particles)
	particles.global_position = player.global_position
	particles.set_emitting(true)
	player.queue_free()
	await  get_tree().create_timer(0.5).timeout
	GameManager.score_screen.apear()

func update_colisions() -> void:
	$CollisionShape3D.set_disabled(not is_visible_in_tree())
