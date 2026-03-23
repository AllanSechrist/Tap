extends Node2D
class_name LaserEffect

@onready var laser: CPUParticles2D = $CPUParticles2D

func fire() -> void:
	laser.restart()
	laser.emitting = true
	
	var total_time := laser.lifetime + 0.1
	await get_tree().create_timer(total_time).timeout
	queue_free()
