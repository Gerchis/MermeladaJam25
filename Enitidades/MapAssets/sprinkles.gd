extends Node3D

@onready var modelo: MeshInstance3D = %Modelo
@onready var pick_up_sound: AudioStreamPlayer = %PickUpSound
@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D

var time_count: float = 0.0
var init_height: float = 0.0

func _ready() -> void:
	init_height = modelo.position.y
	var rand = randf()
	var rand_color = Color.from_hsv(rand, 1.0, 5.)
	var material = modelo.mesh.surface_get_material(0)
	material.albedo_color = rand_color
	modelo.mesh.surface_set_material(0, material.duplicate())
	get_parent_node_3d().visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()

func _process(delta: float) -> void:
	time_count += delta * 4
	modelo.position.y = init_height + sin(time_count)*0.2
	rotate_y(2.0 * delta)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	
	GameManager.extra_score += 75
	pick_up_sound.play()
	collision_shape_3d.set_disabled(true)
	
	var tween = create_tween()
	tween.tween_property(self, "scale",Vector3.ONE * 0.1, 0.3)
	await  tween.finished
	queue_free()

func _on_visibility_changed() -> void:
	%CollisionShape3D.set_disabled(not is_visible_in_tree())
