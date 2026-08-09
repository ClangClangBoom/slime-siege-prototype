extends CharacterBody2D

@export var speed: float = 120.0

@onready var hitbox_pivot: Node2D = $HitboxPivot
@onready var sword_collision: CollisionShape2D = $HitboxPivot/SwordHitbox/CollisionShape2D

var last_direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	#start with the sword inactive so it doesn't hit things constantly
	sword_collision.disabled = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_basic_attack"):
		swing_sword()
		
func swing_sword() -> void:
	print("Swung sword!")
	
	#rotate the pivot depending on facing direction
	if last_direction == Vector2.RIGHT:
		hitbox_pivot.rotation_degrees = 270
	elif last_direction == Vector2.DOWN:
		hitbox_pivot.rotation_degrees = 0
	elif last_direction == Vector2.LEFT:
		hitbox_pivot.rotation_degrees = 90
	elif last_direction == Vector2.UP:
		hitbox_pivot.rotation_degrees = 180
	
	#enable the collision briefly
	sword_collision.disabled = false
	#wait a second for an active frame
	await get_tree().create_timer(0.1).timeout
	sword_collision.disabled = true

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * speed
	move_and_slide()
	
	#if the player is actually moving update last known direction
	if direction != Vector2.ZERO:
		last_direction = direction
	
	#optional flip sprite
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = direction.x > 0
