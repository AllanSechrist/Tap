extends Node2D
class_name ShipAvatar

#const LASER_EFFECT = preload("uid://bsduwcnx8btvt")
#const LASER_EFFECT = preload("uid://diteqlph40eak")
@export var fire_rate_min: float = 5.0
@export var fire_rate_max: float = 10.0
@export var cast_length: float = 2.0 # How long should the ship fire the laser.
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cast_timer: Timer = $CastTimer
@onready var fire_timer: Timer = $FireTimer

@onready var laser_ray_cast: RayCast2D = $LaserRayCast

var target_position: Vector2
var fire_target_position: Vector2

func _ready() -> void:
	randomize_fire_timer()
	fire_timer.timeout.connect(_on_fire_timer_timeout)
	fire_timer.wait_time = randf_range(fire_rate_min, fire_rate_max)
	fire_timer.start(randf_range(0.1, fire_timer.wait_time))
	cast_timer.timeout.connect(_on_cast_timer_timeout)
	cast_timer.wait_time = cast_length

func _process(delta: float) -> void:
	global_position = global_position.lerp(target_position, 6.0 * delta)
	
func set_icon(texture: Texture2D) -> void:
	sprite_2d.texture = texture
	
func randomize_fire_timer() -> void:
	fire_timer.wait_time = randf_range(fire_rate_min, fire_rate_max)

func fire_laser() -> void:
	print("Ship fired a laser!")
	var angle_to_target := global_position.angle_to_point(fire_target_position)
	laser_ray_cast.global_position = global_position
	laser_ray_cast.global_rotation = angle_to_target
	laser_ray_cast.is_casting = true

func _on_fire_timer_timeout() -> void:
	fire_laser()
	randomize_fire_timer()
	cast_timer.start()
	print("Fire time out!")

func _on_cast_timer_timeout() -> void:
	laser_ray_cast.is_casting = false
	fire_timer.start()
	print("Caster time out!")
