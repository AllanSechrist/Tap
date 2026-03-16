extends Node2D

@onready var small_stars: CPUParticles2D = $SmallStars
@onready var medium_stars: CPUParticles2D = $MediumStars
@onready var large_stars: CPUParticles2D = $LargeStars

@export_category("Star_amounts")
@export var small_amount: int = 250
@export var medium_amount: int = 80
@export var large_amount: int = 10

func _ready() -> void:
	small_stars.amount = small_amount
	medium_stars.amount = medium_amount
	large_stars.amount = large_amount
