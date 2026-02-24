class_name EventBus
extends Node

# ------- State -------
signal resource_changed(type: ResourceHandler.resource_type, amount: int)
# signal for updating inventory/upgrades
# signal for moving to another area

# ------- UI -------
signal update_resource_label(type: ResourceHandler.resource_type, new_value: int)
