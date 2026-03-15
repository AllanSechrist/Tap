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
	# set iron ore label
	resource_labels[0].text = "%s: %d" % [RESOURCE_DISPLAY_NAMES[0], 0]
	#for label in resource_labels.keys():
		#set_label_visibility(resource_labels[label], 0)
	
func _on_resource_changed(type: ResourceHandler.resource_type, new_value: int) -> void:
	var display_name = RESOURCE_DISPLAY_NAMES[type]
	var label = resource_labels[type]
	label.text = "%s: %d" % [display_name, new_value]
	#set_label_visibility(label, new_value)
	
#func set_label_visibility(label: Label, value: int) -> void:
	#if value == 0:
		#label.visible = false
	#else:
		#label.visible = true
		
func _on_shop_menu_pressed() -> void:
	Events.toggle_shop_menu.emit()
