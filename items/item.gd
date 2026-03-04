extends Resource
class_name Item

@export_category("Info")
@export var id: StringName
@export var display_name: String
@export var description: String

@export_category("Visuals")
@export var icon: Texture2D

@export_category("Economy")
@export var costs: Dictionary[ResourceHandler.resource_type, int] = {}
