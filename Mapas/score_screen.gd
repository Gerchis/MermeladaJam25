extends TextureRect

@onready var modelado_muffin_score_001: Node3D = %Modelado_Muffin_Score_001
@onready var score: Label = %Score
@onready var highscore: Label = %Highscore
@onready var return_button: Button = %ReturnButton
@onready var retry_button: Button = %RetryButton
@onready var main_menu: TextureRect = %MainMenu


func _ready() -> void:
	hide()
	GameManager.score_screen = self

func _process(delta: float) -> void:
	rotate_muffin(delta)

func rotate_muffin(delta) -> void:
	modelado_muffin_score_001.rotate_y(2.0 * delta)
	#modelado_muffin_score_001.rotate_object_local(Vector3.UP, 2.0 * delta)

func apear() -> void:
	global_position.y = -869.0
	
	if GameManager.run_score > GameManager.stored_data.highscore:
		GameManager.stored_data.highscore = GameManager.run_score
	
	AudioManager.play_background_music(AudioManager.MUSICA_PANTALLA_FINAL_001)
	
	show()
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2.ZERO, 0.2)
	var score_tween = create_tween()
	score_tween.tween_method(update_score, 0, GameManager.run_score, 2.0)
	var highscore_tween = create_tween()
	highscore_tween.tween_method(update_highscore, 0, GameManager.stored_data.highscore, 2.0)
	
	retry_button.grab_focus()

func update_score(value: int)-> void:
	score.text = "Puntuación: " + str(value)

func update_highscore(value: int) -> void:
	highscore.text = "Mejor Puntuación: " + str(value)

func _on_return_button_pressed() -> void:
	main_menu.game_scene.queue_free()
	await main_menu.game_scene.tree_exited
	main_menu.show()
	AudioManager.play_background_music(AudioManager.MAIN_MENU_BSO_001)
	hide()
	main_menu.play_button.grab_focus()

func _on_retry_button_pressed() -> void:
	main_menu.game_scene.queue_free()
	await main_menu.game_scene.tree_exited
	main_menu._on_play_button_pressed()
	hide()
