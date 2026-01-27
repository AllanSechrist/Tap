extends Node2D
class_name Planet

@onready var planet: Sprite2D = $Planet

var on_planet := false 
	
func _on_area_2d_mouse_entered() -> void:
	on_planet = true
	
func _on_area_2d_mouse_exited() -> void:
	on_planet = false
