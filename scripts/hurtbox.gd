class_name Hurtbox
extends Area2D

@export var health_component: Node	#we will link a health component here soon

func _ready() -> void:
	return
	
func take_damage(damage: int) -> void:
	if health_component:
		health_component.apply_damage(damage)
