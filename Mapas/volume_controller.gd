extends PanelContainer

@export var panel_container: StyleBoxFlat
@onready var _0: TextureButton = %"0"
@onready var _20: TextureButton = %"20"
@onready var _40: TextureButton = %"40"
@onready var _60: TextureButton = %"60"
@onready var _80: TextureButton = %"80"
@onready var _100: TextureButton = %"100"

const SPRIT_SHEET_BTNS_SIN_VOLUMEN_001 = preload("res://Recursos/Sprites/SpritSheet_BTNS_SinVolumen_001.png")
const SPRIT_SHEET_BTNS_VOLUMEN_001 = preload("res://Recursos/Sprites/SpritSheet_BTNS_Volumen_001.png")

func _ready() -> void:
	if AudioServer.get_bus_volume_linear(0) < 0.2:
		_on_0_pressed()
	elif AudioServer.get_bus_volume_linear(0) < 0.4:
		_on_20_pressed()
	elif AudioServer.get_bus_volume_linear(0) < 0.6:
		_on_40_pressed()
	elif AudioServer.get_bus_volume_linear(0) < 0.8:
		_on_60_pressed()
	elif AudioServer.get_bus_volume_linear(0) < 1.:
		_on_80_pressed()
	else:
		_on_100_pressed()

func _process(delta: float) -> void:
	if has_focus() and Input.is_action_just_pressed("ui_right"):
		var new_volume = AudioServer.get_bus_volume_linear(0) + 0.2
		new_volume = min(new_volume, 1.0)
		AudioServer.set_bus_volume_linear(0, new_volume)
		_ready()
	elif has_focus() and Input.is_action_just_pressed("ui_left"):
		var new_volume = AudioServer.get_bus_volume_linear(0) - 0.2
		new_volume = max(new_volume, 0.0)
		AudioServer.set_bus_volume_linear(0, new_volume)
		_ready()

func _on_focus_entered() -> void:
	add_theme_stylebox_override("panel", panel_container)

func _on_focus_exited() -> void:
	add_theme_stylebox_override("panel", StyleBoxEmpty.new())


func _on_0_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 0.0)
	GameManager.stored_data.volume = 0.0
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001


func _on_20_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 0.2)
	GameManager.stored_data.volume = 0.2
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001


func _on_40_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 0.4)
	GameManager.stored_data.volume = 0.4
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001


func _on_60_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 0.6)
	GameManager.stored_data.volume = 0.6
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001

func _on_80_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 0.8)
	GameManager.stored_data.volume = 0.8
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_SIN_VOLUMEN_001

func _on_100_pressed() -> void:
	AudioServer.set_bus_volume_linear(0, 1.0)
	GameManager.stored_data.volume = 1.
	_0.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_20.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_40.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_60.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_80.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
	_100.texture_normal = SPRIT_SHEET_BTNS_VOLUMEN_001
