extends CharacterBody2D

@onready var state_machine: StateMachine = $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_pivot: Node2D = $HitboxPivot
@onready var sword_collision: CollisionShape2D = $HitboxPivot/SwordHitbox/CollisionShape2D

var last_direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	#start with the sword inactive so it doesn't hit things constantly
	sword_collision.disabled = true
	
	state_machine.init(self, animated_sprite)

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

func _process(delta: float) -> void:
	state_machine.update(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
