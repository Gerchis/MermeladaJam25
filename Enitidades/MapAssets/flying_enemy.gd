extends Node3D

var on_screen = false
var player: PlayerBehaviour

const PROJECTILE = preload("res://Enitidades/MapAssets/projectile.tscn")
const DEATH_PARTICLES = preload("res://Enitidades/MapAssets/death_particles.tscn")

@onready var mesh_caramelo_001: MeshInstance3D = %Mesh_Caramelo_001

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
	var rand = randf()
	var rand_color = Color.from_hsv(rand, 1.0, 0.9)
	mesh_caramelo_001.mesh.surface_get_material(0).albedo_color = rand_color

func shoot() -> void:
	if not on_screen || global_position.y > 20. || global_position.y < 0. || player == null: return
	var dir = player.global_position - global_position
	var projectile = PROJECTILE.instantiate()
	add_child(projectile)
	projectile.dir = dir.normalized()

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	on_screen = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	on_screen = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	GameManager.extra_score += 150
	var particles := DEATH_PARTICLES.instantiate()
	get_parent().add_child(particles)
	particles.global_position = global_position
	particles.set_emitting(true)
	queue_free()
	return


func _on_visibility_changed() -> void:
	%CollisionShape3D.set_disabled(not is_visible_in_tree())
