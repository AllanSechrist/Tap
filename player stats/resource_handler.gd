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
	Events.resource_changed.connect(_on_resource_changed)

func _on_resource_changed(type: resource_type, amount: int) -> void:
	resources[type] += amount
	Events.update_resource_label.emit(type, resources[type])
