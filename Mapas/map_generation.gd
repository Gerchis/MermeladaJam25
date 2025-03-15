extends Node3D

const map_size = Vector2(80, 20)

@export var player : PlayerBehaviour
@export var cam : Camera3D
@export var tutorial_map : PackedScene
@export var game_maps : Array[PackedScene]

var stored_map: Array[Dictionary] = []
var sort_array : Array[int] = []
var iteration : int = 0
var world_lenght : int = 0

func _ready() -> void:
	generate_map()

func _process(delta: float) -> void:
	handle_player_verticality()
	handle_player_horizontality()

func generate_map():
	add_map(tutorial_map, -1)
	
	for i in range(game_maps.size()):
		sort_array.append(i)
	sort_array.shuffle()
	
	add_map(game_maps[sort_array[0]], 0)

func add_map(map: PackedScene, x_offset: int):
	var stored_dict = {}
	var main_map = map.instantiate()
	var top_map = map.instantiate()
	var bot_map = map.instantiate()
	
	add_child(main_map)
	add_child(top_map)
	add_child(bot_map)
	
	stored_dict["main"] = main_map
	stored_dict["top"] = top_map
	stored_dict["bot"] = bot_map
	
	stored_map.append(stored_dict)
	
	main_map.position.x = map_size.x * x_offset
	top_map.position.x = map_size.x * x_offset
	bot_map.position.x = map_size.x * x_offset
	
	top_map.position.y = map_size.y
	bot_map.position.y = -map_size.y

func handle_player_verticality() -> void:
	if player.global_position.y <= -4.0:
		player.global_position.y += map_size.y
		cam.global_position.y += map_size.y
	
	if player.global_position.y >= map_size.y + 4.0:
		player.global_position.y -= map_size.y
		cam.global_position.y -= map_size.y

func handle_player_horizontality()->void:
	world_lenght = max(world_lenght, stored_map.size())
	
	if player.global_position.x > (map_size.x * 0.5) + ((world_lenght-2) * map_size.x) and stored_map.size() >= 1:
		delete_previous_maps()
	
	if player.global_position.x > (map_size.x * 0.5 +10) + ((world_lenght-2) * map_size.x):
		regenerate_map()

func delete_previous_maps() -> void:
	
	for i in stored_map.size() - 1:
		stored_map[i]["main"].queue_free()
		stored_map[i]["top"].queue_free()
		stored_map[i]["bot"].queue_free()
	
	stored_map = [stored_map.back()]

func regenerate_map() -> void:
	iteration += 1
	
	stored_map[0]["main"].position.x = -map_size.x
	stored_map[0]["top"].position.x = -map_size.x
	stored_map[0]["bot"].position.x = -map_size.x
	player.global_position.x -= map_size.x * (world_lenght - 1)
	cam.global_position.x -= map_size.x * (world_lenght - 1)
	
	
	for i in range(min(world_lenght, sort_array.size())):
		add_map(game_maps[sort_array[i]], i)
	
