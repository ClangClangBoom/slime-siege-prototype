extends CharacterBody2D

var speed = 75
var player: Node2D # or CharacterBody2D / CharacterBody3D

func _ready():
	#Finds the player automatically when the enmy enters the game
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		#calculate direction to player
		var direction = (player.global_position - global_position).normalized()
		#if we are not close enough to the player lets keep moving
		if player.global_position.distance_to(position) > 50:
			#move the enemy
			velocity = direction * speed
			move_and_slide()
		else:	#stop moving and exit the function
			return
		
		#flip sprite horizontally
		if direction.x != 0:
			$Sprite2D.flip_h = direction.x < 0
