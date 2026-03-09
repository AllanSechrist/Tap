extends PanelContainer
class_name ItemCard

@onready var card_name_label: Label = %CardNameLabel
@onready var card_icon: TextureRect = %CardIcon
@onready var perchase_button: Button = %PerchaseButton

var item: Item

func setup(new_item: Item):
	item = new_item
	
	card_icon.texture = item.card_icon
	card_name_label.text = item.display_name
	
	var text := "Buy"
	for resource in item.costs:
		text += " %s: %d " % [resource, item.costs[resource]]
		
	perchase_button.text = text
