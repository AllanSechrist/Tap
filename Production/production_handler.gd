extends Node
class_name ProductionHandler

@export var inventory: Dictionary[StringName, int]
@export var owned_upgrades: Dictionary[StringName, bool]
@export var tick_rate: float = 1.0
@export var catalog: ShopCatalog

var item_lookup: Dictionary = {}

@onready var timer: Timer = $Timer

func _ready() -> void:
	Events.remove_item.connect(_on_remove_item)
	Events.perchase_failed.connect(_on_perchase_failed)
	Events.perchase_success.connect(_on_perchase_success)
	timer.wait_time = tick_rate
	timer.timeout.connect(_on_tick)
	timer.start()
	
	for item in catalog.items:
		item_lookup[item.id] = item
		
#func apply_upgrades(item: Item, owned_upgrades: Dictionary, alll):
	#pass
	
func get_total_production() -> int:
	var total: int = 0
	for item_id in inventory.keys():
		var owned_count: int = inventory[item_id]
		
		if owned_count <= 0:
			continue
			
		var item: Item = item_lookup.get(item_id)
		if item == null:
			continue
			
		for resource_type in item.production.keys():
			var produced_per_tick: int = int(item.production[resource_type])
			var total_amount: int = owned_count * produced_per_tick
			total += total_amount
		
		total *= apply_upgrade_bonus(item)
	return total
	
func apply_upgrade_bonus(item: Item) -> int:
	var total: int = 1
	for upgrade_id in owned_upgrades.keys():
		var upgrade = item_lookup.get(upgrade_id)
		if upgrade.target_item == item:
			total *= upgrade.effect_value
			
	return total
		
func get_owned_upgrades() -> Dictionary:
	return owned_upgrades.duplicate()

func _on_tick() -> void:
	var total = get_total_production()
	if total > 0:
		Events.add_resource.emit(0, total)

func _on_perchase_failed(item: Item, message: String) -> void:
	var item_name = item.display_name
	print(item_name)
	print(message)
	
func _on_perchase_success(item: Item, amount: int) -> void:
	if item == null or amount <= 0:
		return
		
	if item is Ship:
		inventory[item.id] = inventory.get(item.id, 0) + amount
		Events.update_owned_label.emit(item, inventory[item.id])
		Events.update_ore_per_second_label.emit(get_total_production())
		#DEBUG
		if item.id == "small_ship":
			Events.update_ship_avatars.emit(item, inventory["small_ship"])
		#END DEBUG
	elif item is Upgrade:
		owned_upgrades[item.id] = owned_upgrades.get(item.id, 0) + 1
		Events.update_ore_per_second_label.emit(get_total_production())
		print(owned_upgrades)
	
func _on_remove_item(item: Item, amount: int) -> void:
	if item == null or amount <= 0:
		return
	
	inventory[item.id] = max(0, inventory.get(item.id, 0) - amount)

#DEBUG
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		print("plus one small drill")
		inventory["small_ship"] = inventory.get("small_ship", 0) + 1
		Events.update_ore_per_second_label.emit(get_total_production())
#END DEBUG
