extends MeshInstance3D

const DEATH_PARTICLES = preload("res://Enitidades/MapAssets/death_particles.tscn")

var lifetime :float = 0.0
var dir: Vector3
var speed: float = 7.0

func _ready() -> void:
	var rand = randf()
	var rand_color = Color.from_hsv(rand, 1.0, 0.9)
	mesh.surface_get_material(0).albedo_color = rand_color

func _process(delta: float) -> void:
	lifetime += delta
	
	global_translate(dir * speed * delta)
	
	if lifetime > 5.0: queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	
	var particles := DEATH_PARTICLES.instantiate()
	var player : PlayerBehaviour = body as PlayerBehaviour
	add_child(particles)
	particles.global_position = player.global_position
	particles.set_emitting(true)
	player.queue_free()
	await  get_tree().create_timer(0.5).timeout
	GameManager.score_screen.apear()
