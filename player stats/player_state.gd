class_name PlayerState
extends Node

enum resource_type {IRON_ORE, COPPER_ORE, IRON_PLATE, COPPER_PLATE}

var resources := {
	resource_type.IRON_ORE: 0,
	resource_type.COPPER_ORE: 0,
	resource_type.IRON_PLATE: 0,
	resource_type.COPPER_PLATE: 0,
}

@export var starting_currency := 0
var currency: int = 0:
	set(value):
		currency = value

func _ready() -> void:
	currency = starting_currency
	Events.currency_changed.connect(_on_resource_changed)
	
func _on_resource_changed(amount: int) -> void:
	currency += amount
	Events.update_resource_label.emit(currency)
