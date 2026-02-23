class_name UpgradeBase
extends Resource

@export_group("Visuals")
@export var name: String
@export_multiline var description: String
@export var icon: Texture2D

@export_group("Gameplay Data")
@export var amount_per_second := 1
@export var cost := 0

var COST_MULTIPLIER := 1.15
var level := 0
