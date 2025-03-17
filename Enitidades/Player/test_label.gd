extends Label3D

@onready var state_machine: StateMachine = $"../StateMachine"

func _process(delta: float) -> void:
	text = state_machine.state.name
