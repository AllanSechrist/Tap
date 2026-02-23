extends Control
class_name UI

@onready var iron_ore_label: Label = %IronOreLabel

func _ready() -> void:
	Events.update_resource_label.connect(_on_resource_changed)
	iron_ore_label.text = "Iron Ore: 0"
	
func _on_resource_changed(value: int) -> void:
	iron_ore_label.text = "Iron Ore: " + str(value)
	
