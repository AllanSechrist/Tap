extends Node2D
class_name ShipAvatar

@onready var sprite_2d: Sprite2D = $Sprite2D
var target_position: Vector2

func set_icon(texture: Texture2D) -> void:
	sprite_2d.texture = texture
	
func _process(delta: float) -> void:
	global_position = global_position.lerp(target_position, 6.0 * delta)
