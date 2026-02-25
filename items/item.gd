extends Resource
class_name Item

@export var id: StringName
@export var display_name: String
@export var description: String
@export var icon: Texture2D
@export var cost: Dictionary[ResourceHandler.resource_type, int]
