extends Node3D

const DEATH_PARTICLES = preload("res://Enitidades/MapAssets/death_particles.tscn")

@onready var modelo: Node3D = %Modelo
@onready var right_ray: RayCast3D = %RightRay
@onready var left_ray: RayCast3D = %LeftRay
@onready var right_shape: ShapeCast3D = %RightShape
@onready var left_shape: ShapeCast3D = %LeftShape

var move_right: bool = true

var speed: float = 5.0

func _ready() -> void:
	var rand = randf()
	var rand_color = Color.from_hsv(rand, 1.0, 0.9)
	modelo.mesh.surface_get_material(0).albedo_color = rand_color

func _process(delta: float) -> void:
	if move_right:
		translate(Vector3.RIGHT * speed * delta)
		modelo.rotation_degrees.y = 0.0
		if not right_ray.is_colliding() || right_shape.is_colliding():
			move_right = false
	else:
		translate(-Vector3.RIGHT * speed * delta)
		modelo.rotation_degrees.y = 180.0
		if not left_ray.is_colliding() || left_shape.is_colliding():
			move_right = true

func _on_hurtbox_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	
	if body.global_position.y - global_position.y > 1.:
		GameManager.extra_score += 200
		var particles := DEATH_PARTICLES.instantiate()
		get_parent().add_child(particles)
		particles.global_position = global_position
		particles.set_emitting(true)
		queue_free()
		return
	
	var particles := DEATH_PARTICLES.instantiate()
	var player : PlayerBehaviour = body as PlayerBehaviour
	add_child(particles)
	particles.global_position = player.global_position
	particles.set_emitting(true)
	player.queue_free()
	await  get_tree().create_timer(0.5).timeout
	GameManager.score_screen.apear()


func _on_collision_shape_3d_visibility_changed() -> void:
	%CollisionShape3D.set_disabled(not is_visible_in_tree())
