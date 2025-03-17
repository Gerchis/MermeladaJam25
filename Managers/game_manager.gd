extends Node

const FILE_PATH = "user://sored_data.tres"

var main_menu : Control
var score_screen : Control
var stored_data : StoredData

var run_score : int :
	get():
		return time_score + extra_score
var time_score : int = 0
var extra_score : int = 0


func _ready() -> void:
	stored_data = StoredData.new()
	load_file()
	AudioServer.set_bus_volume_linear(0, stored_data.volume)

func _exit_tree() -> void:
	store_file()

func store_file()-> void:
	ResourceSaver.save(stored_data, FILE_PATH)

func load_file()-> void:
	if FileAccess.file_exists(FILE_PATH):
		stored_data = ResourceLoader.load(FILE_PATH)
