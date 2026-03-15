extends Button

@export var animation_target := Vector2(1.05, 1.05)
@export var duration: float = 0.35

var animation_original := Vector2.ONE
var tween 

func _ready() -> void:
	pivot_offset = size / 2

func _on_mouse_entered() -> void:
	animate(animation_target, Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	animate(animation_original, Tween.EASE_IN)
	
func animate(target: Vector2, type:Tween.EaseType) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(tween.TRANS_SINE)
	tween.set_ease(type)
	tween.tween_property(self, "scale", target, duration)
