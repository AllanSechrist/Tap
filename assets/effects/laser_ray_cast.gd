extends RayCast2D

@export var cast_speed := 700.0
@export var max_length := 1400.0
@export var is_casting := false: set = set_is_casting
@export var color := Color.WHITE: set = set_color
@onready var line_2d: Line2D = $Line2D

func _ready() -> void:
	set_color(color)
	set_is_casting(is_casting)

func _physics_process(delta: float) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		cast_speed * delta
	)

func set_is_casting(new_value: bool) -> void:
	if is_casting == new_value:
		return
	is_casting = new_value
	
	set_physics_process(is_casting)
	
	if is_casting == false:
		target_position.x = 0.0

func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d == null:
		return
	line_2d.modulate = new_color
