extends CharacterBody2D

var speed = 110

@export var player: Node2D #drag player into this slot in the inspector

func _physics_process(delta: float) -> void:
	if player:
		#calculate direction to player
		var direction = (player.global_position - global_position).normalized()
		
		#move the enemy
		velocity = direction * speed
		move_and_slide()
		
		#optional flip sprite
		if direction.x != 0:
			$Sprite2D.flip_h = direction.x < 0
