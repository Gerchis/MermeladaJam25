extends PanelContainer

@export var panel_container: StyleBoxFlat

@onready var effect: CanvasLayer = %Effect
@onready var check: TextureButton = %Check

const SPRIT_SHEET_BTNS_SIN_VOLUMEN_001 = preload("res://Recursos/Sprites/SpritSheet_BTNS_SinVolumen_001.png")
const SPRIT_SHEET_BTNS_VOLUMEN_001 = preload("res://Recursos/Sprites/SpritSheet_BTNS_Volumen_001.png")

func _ready() -> void:
	if GameManager.stored_data.shader_effect:
		effect.show()
		check.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	else:
		effect.hide()
		check.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001

func _process(delta: float) -> void:
	if has_focus() and Input.is_action_just_pressed("ui_accept"):
		_on_check_pressed()

func _on_focus_entered() -> void:
	add_theme_stylebox_override("panel", panel_container)

func _on_focus_exited() -> void:
	add_theme_stylebox_override("panel", StyleBoxEmpty.new())

func _on_check_pressed() -> void:
	if effect.is_visible():
		effect.hide()
		check.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
		GameManager.stored_data.shader_effect = false
	else:
		effect.show()
		check.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
		GameManager.stored_data.shader_effect = true
