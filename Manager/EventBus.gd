class_name EventBus
extends Node

# ------- State -------
signal add_resource(type: ResourceHandler.resource_type, amount: int)
signal subtract_resource(type: ResourceHandler.resource_type, amount: int)
signal remove_item(item: Item, amount: int)
# signal for updating inventory/upgrades
# signal for moving to another area

# ------- UI -------
signal update_resource_label(type: ResourceHandler.resource_type, new_value: int)
signal update_item_label(item: Item, amount: int) #pass in item type and amount

# ------- SHOP -------
signal perchase_request(item: Item, amount: int)
signal perchase_success(item: Item, amount: int)
signal perchase_failed(item: Item, message: String)
signal request_player_resources()
signal send_player_resources(resources: Dictionary)
