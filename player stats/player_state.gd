class_name PlayerState
extends Node

@export var starting_currency := 1
var currency: int

func _ready() -> void:
	currency = starting_currency
	Events.currency_changed.connect(_on_currency_changed)
	
func _on_currency_changed(amount: int) -> void:
	print("I'm from the player!")
	print(amount)

	
