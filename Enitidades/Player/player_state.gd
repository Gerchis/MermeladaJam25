class_name PlayerState
extends Node

signal transition_to(next_state: String, data: Dictionary)

const IDLE: String = "Idle"
const WALK: String = "Walk"
const JUMP: String = "Jump"
const FALL: String = "Fall"

var player: PlayerBehaviour
var anim: AnimationTree

func _ready() -> void:
	await  owner.ready
	player = owner as PlayerBehaviour
	anim = owner.get_node("AnimationTree") as AnimationTree

func _enter(previous_state: String, data := {}) -> void:
	pass

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	pass
