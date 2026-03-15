extends Control
class_name ShopUI

const ITEM_CARD = preload("res://items/itemUI/item_card.tscn")
@onready var grid_container: GridContainer = %GridContainer

@export var shop_items: ShopCatalog

func _ready() -> void:
	populate_shop()
	
func populate_shop() -> void:
	for item in shop_items.items:
		var card = ITEM_CARD.instantiate()
		grid_container.add_child(card)
		card.setup(item)


func _on_exit_button_pressed() -> void:
	Events.toggle_shop_menu.emit()
