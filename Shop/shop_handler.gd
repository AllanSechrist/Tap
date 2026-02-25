extends Node
class_name ShopHandler

func _ready() -> void:
	Events.purchase_request.connect(_on_perchase_request)

func can_buy(item: Item) -> bool:
	return true
	
func _on_perchase_request(item: Item) -> void:
	# Check if player has enough resources to make a perchase
	if can_buy(item):
		print("yes")
	else:
		print("no")
	pass
	# >>> display message telling player they do not have enough resources to make a perchase.
	# if player has enough resources, signal the amount of resources to remove and which item to increase
	# Events.purchase_success.emit(item, type, amount)
