class_name Hitbox
extends Area2D

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	print("Hitbox has touched: ", area.name) #
	
	#check if the area we touched is an instance of hurtbox class
	if area is Hurtbox:
		print("It's a hurtbox! calling take_damage") #
		area.take_damage(damage)
	else:
		print("NOT a hurtbox it is a: ", area.get_class(), "with script: ", area.get_script())
