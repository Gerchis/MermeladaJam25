extends Label

func _process(delta: float) -> void: 
	text = str(GameManager.run_score)
