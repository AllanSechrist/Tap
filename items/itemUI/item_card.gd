extends PanelContainer
class_name ItemCard

@onready var card_name_label: Label = %CardNameLabel
@onready var card_icon: TextureRect = %CardIcon
@onready var perchase_button: Button = %PerchaseButton
@onready var description_label: Label = %DescriptionLabel

var item: Item
var amount := 1

func setup(new_item: Item):
	item = new_item
	
	card_icon.texture = item.icon
	card_name_label.text = item.display_name
	description_label.text = item.description
	
	var text := "Buy"
	for resource in item.costs:
		text += " %d " % [item.costs[resource]]
		
	perchase_button.text = text


func _on_perchase_button_pressed() -> void:
	Events.perchase_request.emit(item, amount)
