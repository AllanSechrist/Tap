class_name EventBus
extends Node

# ------- State -------
signal resource_changed(type: ResourceHandler.resource_type, amount: int)
signal item_changed()
# signal for updating inventory/upgrades
# signal for moving to another area

# ------- UI -------
signal update_resource_label(type: ResourceHandler.resource_type, new_value: int)
signal update_item_label() #pass in item type and amount

# ------- SHOP -------
signal purchase_request(item: String, resources: Dictionary)#change to pass item type
signal purchase_success(item: String, type: ResourceHandler.resource_type, amount: int)
