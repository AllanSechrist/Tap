class_name GameManager
extends Node

@export var planet: Planet
@export var click_value := 1

@onready var score_label: Label = %ScoreLabel


var score: int = 0:
	set(value):
		score = value

func _unhandled_input(event: InputEvent) -> void:
	if planet.on_planet:
		if event.is_action_pressed("click"):
			update_score(click_value)
			score_label.text = "Score: " + str(score)
			
func update_score(value: int) -> void:
	score += value
