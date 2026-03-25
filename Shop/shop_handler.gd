extends Node
class_name ShopHandler

@export var catalog: ShopCatalog
@export var resource_handler: ResourceHandler
@export var production_handler: ProductionHandler

func _ready() -> void:
	Events.perchase_request.connect(_on_perchase_request)

func can_buy(item: Item, resources: Dictionary) -> bool:
	if not can_afford(item, resources):
		return false
	
	if item is Upgrade:
		if production_handler.owned_upgrades.get(item.id, false):
			return false
	return true

func can_afford(item: Item, resources: Dictionary) -> bool:
	for type in item.costs.keys():
		var cost := int(item.costs[type])
		var have := int(resources.get(type, 0))
		if have < cost:
			return false
	return true
	
#func _on_perchase_request(item: Item, amount: int) -> void:
	#pending_item = item
	#pending_amount = amount
	#Events.request_player_resources.emit()
	
func _on_perchase_request(item: Item, amount: int) -> void:
	if item == null or amount == 0:
		return
	
	var resources := resource_handler.get_resources()
	var owned_upgrades := production_handler.get_owned_upgrades()
	
	if can_buy(item, resources):
		for type in item.costs.keys():
			var cost := int(item.costs[type])
			Events.subtract_resource.emit(type, cost)
		
		Events.perchase_success.emit(item, amount)
	else:
		Events.perchase_failed.emit(item, "Not enough resources")
