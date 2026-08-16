extends State

func enter() -> void:
	character.velocity = Vector2.ZERO
	animated_sprite.play("idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# If player starts pressing keys, transition to Run state
	if direction != Vector2.ZERO:
		transition.emit(self, "Run")
