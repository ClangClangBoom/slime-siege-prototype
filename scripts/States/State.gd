class_name State
extends Node

# A signal to let the state machine know we want to switch states
signal transition(state: State, new_state_name: String)

# Reference to your player/character and animated sprite
var character: CharacterBody2D
var animated_sprite: AnimatedSprite2D

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
