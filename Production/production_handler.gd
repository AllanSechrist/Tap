extends Node
class_name ProductionHandler

@export var inventory: Dictionary[StringName, int]
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

func _on_tick() -> void:
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
			
			if total_amount > 0:
				Events.add_resource.emit(resource_type, total_amount)

func _on_perchase_failed(item: Item, message: String) -> void:
	var item_name = item.display_name
	print(item_name)
	print(message)
	
func _on_perchase_success(item: Item, amount: int) -> void:
	if item == null or amount <= 0:
		return
		
	inventory[item.id] = inventory.get(item.id, 0) + amount
	
func _on_remove_item(item: Item, amount: int) -> void:
	if item == null or amount <= 0:
		return
	
	inventory[item.id] = max(0, inventory.get(item.id, 0) - amount)
	
func _unhandled_key_input(event: InputEvent) -> void:	
	if event.is_action_pressed("debug"):
		Events.perchase_request.emit(item_lookup["small_ship"], 1)
