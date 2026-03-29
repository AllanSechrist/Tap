extends RayCast2D

@export var cast_speed := 700.0
@export var max_length := 1400.0
@export var start_distance := 10.0
@export var growth_time := 0.1
@export var is_casting := false: set = set_is_casting
@export var color := Color.WHITE: set = set_color
@onready var line_2d: Line2D = $Line2D
@onready var line_width := line_2d.width

var tween: Tween = null

func _ready() -> void:
	set_color(color)
	set_is_casting(is_casting)

func _physics_process(delta: float) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		cast_speed * delta
	)
	
	var laser_end_position := target_position
	force_raycast_update()
	if is_colliding():
		laser_end_position = to_local(get_collision_point())
	line_2d.points[1] = laser_end_position

func set_is_casting(new_value: bool) -> void:
	if is_casting == new_value:
		return
	is_casting = new_value
	
	set_physics_process(is_casting)
	
	if not line_2d:
		return
	
	if is_casting:
		var laser_start := Vector2.RIGHT * start_distance
		line_2d.points[0] = laser_start
		line_2d.points[1] = laser_start
		appear()
	else:
		target_position = Vector2.ZERO
		disappear()
		
func appear() -> void:
	line_2d.visible = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", line_width, growth_time * 2.0).from(0.0)
	
func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", 0.0, growth_time).from_current()
	tween.tween_callback(line_2d.hide)

func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d == null:
		return
	line_2d.modulate = new_color
