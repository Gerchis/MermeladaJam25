extends TextureRect

const GAME_WINDOW = preload("res://Mapas/game_window.tscn")

@onready var play_button: TextureButton = %PlayButton
@onready var options_button: TextureButton = %OptionsButton
@onready var credits_button: TextureButton = %CreditsButton
@onready var options: PanelContainer = %Options
@onready var credits: PanelContainer = %Credits
@onready var volume_controller: PanelContainer = %VolumeController
@onready var credits_return_button: Button = %CreditsReturnButton

var game_scene: Node3D

func _ready() -> void:
	play_button.grab_focus()
	AudioManager.background_audio_source = %Gameplay_BSO
	AudioManager.play_background_music(AudioManager.MAIN_MENU_BSO_001)

func _on_play_button_pressed() -> void:
	var game_inst := GAME_WINDOW.instantiate()
	owner.add_child(game_inst)
	game_scene = game_inst
	
	AudioManager.play_background_music(AudioManager.GAME_PLAY_BSO_001)
	
	hide()

func _on_options_button_pressed() -> void:
	options.show()
	credits.hide()
	play_button.focus_mode = Control.FOCUS_NONE
	options_button.focus_mode = Control.FOCUS_NONE
	credits_button.focus_mode = Control.FOCUS_NONE
	volume_controller.grab_focus()

func _on_credits_button_pressed() -> void:
	options.hide()
	play_button.focus_mode = Control.FOCUS_NONE
	options_button.focus_mode = Control.FOCUS_NONE
	credits_button.focus_mode = Control.FOCUS_NONE
	credits_return_button.grab_focus()
	
	credits.show()

func _on_return_button_pressed() -> void:
	play_button.focus_mode = Control.FOCUS_ALL
	options_button.focus_mode = Control.FOCUS_ALL
	credits_button.focus_mode = Control.FOCUS_ALL
	play_button.grab_focus()
	options.hide()
	credits.hide()
