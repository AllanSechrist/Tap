class_name EventBus
extends Node

# ------- State -------
signal currency_changed(amount: int)
# signal for updating inventory/upgrades
# signal for moving to another area

# ------- UI -------
signal update_resource_label(value: int)
