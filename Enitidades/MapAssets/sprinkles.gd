extends Node3D

@onready var modelo: MeshInstance3D = %Modelo

var time_count: float = 0.0
var init_height: float = 0.0

func _ready() -> void:
	init_height = modelo.position.y
	var rand = randf()
	var rand_color = Color.from_hsv(rand, 1.0, 0.9)
	modelo.mesh.surface_get_material(0).albedo_color = rand_color

func _process(delta: float) -> void:
	time_count += delta * 4
	modelo.position.y = init_height + sin(time_count)*0.2
	rotate_y(2.0 * delta)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	
	GameManager.extra_score += 75
	
	var tween = create_tween()
	tween.tween_property(self, "scale",Vector3.ONE * 0.1, 0.3)
	await  tween.finished
	queue_free()

func _on_visibility_changed() -> void:
	%CollisionShape3D.set_disabled(not is_visible_in_tree())
