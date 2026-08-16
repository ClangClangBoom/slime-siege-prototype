extends State

@export var speed: float = 200.0

func enter() -> void:
	animated_sprite.play("walk")
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		character.velocity = direction * speed
		
		# Flip sprite based on direction
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0
	else:
		character.velocity = Vector2.ZERO
		# If movement stops, transition back to Idle state
		transition.emit(self, "Idle")
		
	character.move_and_slide()
