extends Item
class_name Ship

@export_category("Production")
@export var production: Dictionary[ResourceHandler.resource_type, int] = {}
