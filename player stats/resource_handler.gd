extends Node
class_name ResourceHandler

enum resource_type {IRON_ORE, COPPER_ORE, IRON_PLATE, COPPER_PLATE}

@export var resources := {
	resource_type.IRON_ORE: 0,
	resource_type.COPPER_ORE: 0,
	resource_type.IRON_PLATE: 0,
	resource_type.COPPER_PLATE: 0,
}

func _ready() -> void:
	Events.add_resource.connect(_on_add_resource)
	Events.subtract_resource.connect(_on_subtract_resource)
	Events.player_resources.connect(_on_player_resources)
func _on_add_resource(type: resource_type, amount: int) -> void:
	resources[type] += amount
	Events.update_resource_label.emit(type, resources[type])

func _on_subtract_resource(type: resource_type, amount: int) -> void:
	resources[type] -= amount
	Events.update_resource_label.emit(type, resources[type])

func _on_player_resources(reqirements: Array) -> bool:
	return false
