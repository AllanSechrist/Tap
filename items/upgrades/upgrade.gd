extends Item
class_name Upgrade

enum EffectType {
	MULTIPLY,
	ADD
}

@export_category("Upgrade Stats")
@export var target_item_id: StringName
@export var effect_type: EffectType = EffectType.MULTIPLY
@export var effect_value: int = 2
