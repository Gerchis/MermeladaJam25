class_name StateMachine
extends Node

@export var init_state : PlayerState = null

@onready var state : PlayerState = (func get_initial_state() -> PlayerState:
	return init_state if init_state != null else get_child(0)).call()

func _ready() -> void:
	for state_node: PlayerState in find_children("*", "PlayerState"):
		state_node.transition_to.connect(state_transition)
	
	await  owner.ready
	state._enter("")

func state_transition(target_state: String, data := {}) -> void:
	if not has_node(target_state):
		printerr(owner.name + ": Can´t transititon to " + target_state + " because it didnt exists")
		return
	
	var previous_state := state.name
	state._exit()
	state = get_node(target_state)
	state._enter(previous_state, data)

func _process(delta: float) -> void:
	if state == null: return
	state._update(delta)

func _physics_process(delta: float) -> void:
	if state == null: return
	state._physics_update(delta)
