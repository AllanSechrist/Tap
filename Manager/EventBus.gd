class_name EventBus
extends Node

# ------- State -------
signal add_resource(type: ResourceHandler.resource_type, amount: int)
signal subtract_resource(type: ResourceHandler.resource_type, amount: int)
signal remove_item(item: Item, amount: int)
# signal for updating inventory/upgrades
# signal for moving to another area

# ------- HUD -------
signal update_resource_label(type: ResourceHandler.resource_type, new_value: int)
signal update_owned_label(item: Item, new_value: int) #pass in item type and amount
signal update_ore_per_second_label(new_value: int)

# ------- SHOP -------
signal toggle_shop_menu()
signal perchase_request(item: Item, amount: int)
signal perchase_success(item: Item, amount: int)
signal perchase_failed(item: Item, message: String)
signal request_player_resources()
signal send_player_resources(resources: Dictionary)
