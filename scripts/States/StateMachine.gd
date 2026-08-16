class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func init(character: CharacterBody2D, animated_sprite: AnimatedSprite2D) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.character = character
			child.animated_sprite = animated_sprite
			child.transition.connect(_on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_child_transition(state: State, new_state_name: String) -> void:
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
