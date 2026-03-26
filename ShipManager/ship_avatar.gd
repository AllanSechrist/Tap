extends Node2D
class_name ShipAvatar

#const LASER_EFFECT = preload("uid://bsduwcnx8btvt")
const LASER_EFFECT = preload("uid://diteqlph40eak")
@export var fire_rate_min: float = 5.0
@export var fire_rate_max: float = 10.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var laser_timer: Timer = $LaserTimer
@onready var laser_ray_cast: RayCast2D = $LaserRayCast

var target_position: Vector2
var fire_target_position: Vector2

func _ready() -> void:
	randomize_fire_timer()
	laser_timer.timeout.connect(_on_laser_timer_timeout)
	laser_timer.wait_time = randf_range(fire_rate_min, fire_rate_max)
	laser_timer.start(randf_range(0.1, laser_timer.wait_time))

func _process(delta: float) -> void:
	global_position = global_position.lerp(target_position, 6.0 * delta)
	
func set_icon(texture: Texture2D) -> void:
	sprite_2d.texture = texture
	
func randomize_fire_timer() -> void:
	laser_timer.wait_time = randf_range(fire_rate_min, fire_rate_max)
	
func fire_laser() -> void:
	print("Ship fired a laser!")
	var angle_to_target := global_position.angle_to_point(fire_target_position)
	laser_ray_cast.global_position = global_position
	laser_ray_cast.global_rotation = angle_to_target
	laser_ray_cast.set_is_casting()

func _on_laser_timer_timeout() -> void:
	fire_laser()
	randomize_fire_timer()
	laser_timer.start()
	
