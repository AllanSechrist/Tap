extends Node
class_name ShopHandler

var pending_item: Item = null

func _ready() -> void:
	Events.perchase_request.connect(_on_perchase_request)
	Events.send_player_resources.connect(_on_player_resources)

func can_afford(item: Item, resources: Dictionary) -> bool:
	for type in item.costs.keys():
		var cost := int(item.costs[type])
		var have := int(resources.get(type, 0))
		if have < cost:
			return false
	return true
	
func _on_perchase_request(item: Item) -> void:
	pending_item = item
	Events.request_player_resources.emit()
	
func _on_player_resources(resources: Dictionary) -> void:
	if pending_item == null:
		return
	
	var item := pending_item
	pending_item = null
	
	if can_afford(item, resources):
		for type in item.costs.keys():
			var cost := int(item.costs[type])
			Events.subtract_resource.emit(type, cost)
		
		Events.perchase_success.emit(item)
	else:
		Events.perchase_failed.emit(item, "Not enough resources")
