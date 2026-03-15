extends Node2D
class_name Planet

@export var resource_type: ResourceHandler.resource_type
@export var click_value := 1
@export_category("Animation")
@export var duration := 0.2
@export var animation_target := Vector2(0.24, 0.24)
@onready var planet: Sprite2D = $Planet
var on_planet := false 
var tween
var animation_original: Vector2

func _ready() -> void:
	animation_original = planet.scale

func _on_area_2d_mouse_entered() -> void:
	on_planet = true
	
func _on_area_2d_mouse_exited() -> void:
	on_planet = false
	
func _unhandled_input(event: InputEvent) -> void:
	if not on_planet:
		return
	if event.is_action_pressed("click"):
		Events.add_resource.emit(resource_type, click_value)
		#shrink_planet()
		animate()
	#elif event.is_action_released("click"):
		#grow_planet()

func animate() -> void:
	if tween:
		tween.kill()
	
	planet.scale = animation_original
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(planet, "scale", animation_target, duration * 0.5)
	tween.tween_property(planet, "scale", animation_original, duration * 0.5)
#func shrink_planet() -> void:
	#if tween:
		#tween.kill()
	#tween = create_tween()
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(planet, "scale", animation_target, duration)
		#
#func grow_planet() -> void:
	#if tween:
		#tween.kill()
	#tween = create_tween()
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(planet, "scale", animation_original, duration)
	
