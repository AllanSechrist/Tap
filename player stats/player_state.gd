class_name PlayerState
extends Node

const EARTH = preload("uid://eowgs1mnq58m")


@export var inventory: Dictionary[StringName, int]
@export var debug_shop_items = EARTH.items

var debug_catalog := {}

func _ready() -> void:
	Events.add_item.connect(_on_add_item)
	Events.remove_item.connect(_on_remove_item)
	Events.perchase_failed.connect(_on_perchase_failed)
	Events.perchase_success.connect(_on_perchase_success)
	# debug
	
	for item in debug_shop_items:
		debug_catalog[item.id] = item

func _on_perchase_failed(item: Item, message: String) -> void:
	var item_name = item.display_name
	print(item_name)
	print(message)
	
func _on_perchase_success(item: Item, amount: int) -> void:
	inventory[item.id] = inventory.get(item.id, 0) + amount
	print(inventory)

func _on_add_item(item: Item, amount: int) -> void:
	inventory[item.id] = inventory.get(item.id, 0) + amount
	
func _on_remove_item(item: Item, amount: int) -> void:
	inventory[item.id] = max(0, inventory.get(item.id, 0) - amount)
	
func _unhandled_key_input(event: InputEvent) -> void:	
	if event.is_action_pressed("debug"):
		Events.perchase_request.emit(debug_catalog["small_ship"], 1)
