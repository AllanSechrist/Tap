extends Node2D
class_name Planet

@onready var planet: Sprite2D = $Planet

var on_planet := false 
	
func _on_area_2d_mouse_entered() -> void:
	on_planet = true
	print(on_planet)
	
func _on_area_2d_mouse_exited() -> void:
	on_planet = false
	print(on_planet)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and on_planet:
		Events.currency_changed.emit(1)
	
