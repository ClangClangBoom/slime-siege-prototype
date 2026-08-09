class_name HealthComponent
extends Node

@export var max_health: int = 10
var current_health: int

signal died
signal health_changed(current_health)

func _ready() -> void:
	current_health = max_health
	
func apply_damage(damage: int) -> void:
	current_health = clamp(current_health - damage, 0, max_health)
	health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()

func die() -> void:
	print("Entity died")
	died.emit()
	
	get_parent().queue_free()
