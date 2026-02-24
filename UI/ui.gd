extends Control
class_name UI

const RESOURCE_DISPLAY_NAMES := {
	ResourceHandler.resource_type.IRON_ORE: "Iron Ore",
	ResourceHandler.resource_type.COPPER_ORE: "Copper Ore",
	ResourceHandler.resource_type.IRON_PLATE: "Iron Plate",
	ResourceHandler.resource_type.COPPER_PLATE: "Copper Plate",
}

@onready var resource_labels := {
	ResourceHandler.resource_type.IRON_ORE: %IronOreLabel,
	ResourceHandler.resource_type.IRON_PLATE: %IronPlateLabel,
	ResourceHandler.resource_type.COPPER_ORE: %CopperOreLabel,
	ResourceHandler.resource_type.COPPER_PLATE: %CopperPlateLabel,
}

func _ready() -> void:
	Events.update_resource_label.connect(_on_resource_changed)
	
func _on_resource_changed(type: ResourceHandler.resource_type, new_value: int) -> void:
	var display_name = RESOURCE_DISPLAY_NAMES[type]
	resource_labels[type].text = "%s: %d" % [display_name, new_value]
	
