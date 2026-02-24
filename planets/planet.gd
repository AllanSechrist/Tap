extends Node2D
class_name Planet

@export var resource_type: ResourceHandler.resource_type
@export var click_value := 1
@onready var planet: Sprite2D = $Planet
var on_planet := false 
	
func _on_area_2d_mouse_entered() -> void:
	on_planet = true
	
func _on_area_2d_mouse_exited() -> void:
	on_planet = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and on_planet:
		Events.resource_changed.emit(resource_type, click_value)
	
