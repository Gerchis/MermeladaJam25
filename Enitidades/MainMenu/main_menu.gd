extends TextureRect

const GAME_WINDOW = preload("res://Mapas/game_window.tscn")

@onready var play_button: TextureButton = %PlayButton
@onready var options_button: TextureButton = %OptionsButton
@onready var credits_button: TextureButton = %CreditsButton

var game_scene: Node3D

func _ready() -> void:
	play_button.grab_focus()

func _on_play_button_pressed() -> void:
	var game_inst := GAME_WINDOW.instantiate()
	owner.add_child(game_inst)
	game_scene = game_inst
	
	hide()
