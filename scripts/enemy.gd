extends CharacterBody2D

var is_dead: bool = false
var speed = 75
var player: Node2D # or CharacterBody2D / CharacterBody3D

@onready var health_component: Node = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	#Finds the player automatically when the enmy enters the game
	player = get_tree().get_first_node_in_group("player")
	#hook up listening compononent for death
	health_component.died.connect(_on_died)
	
func _on_died() -> void:
	print("Slime is reacting to its death")
	is_dead = true
	
	#turn off visuals and physics
	sprite.visible = false
	collision.set_deferred("disabled", true)
	
	#respawning logic?
	await get_tree().create_timer(5.0).timeout
	respawn()
	
func respawn() -> void:
	#reset health back to max through health component
	health_component.current_health = health_component.max_health

	#bring visuals and physics back
	sprite.visible = true
	collision.set_deferred("disabled", false)
	is_dead = false
	
	print("Slime respawn")
	
func _physics_process(delta: float) -> void:
	#if the slime is dead, skip all movement and chase logic
	if is_dead:
		return
		
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
