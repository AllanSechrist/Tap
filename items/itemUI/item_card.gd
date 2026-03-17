extends Control
class_name ItemCard

@onready var card_name_label: Label = %CardNameLabel
@onready var card_icon: TextureRect = %CardIcon
@onready var perchase_button: Button = %PerchaseButton
@onready var description_label: Label = %DescriptionLabel
@onready var buy_label: Label = %BuyLabel
@onready var owned_label: Label = %OwnedLabel
@onready var button_labels: VBoxContainer = %ButtonLabels

var item: Item
var amount := 1

func _ready() -> void:
	Events.update_owned_label.connect(_on_update_owned_label)

func setup(new_item: Item):
	item = new_item
	
	card_icon.texture = item.icon
	card_name_label.text = item.display_name
	description_label.text = item.description
	
	var text := "Buy"
	for resource in item.costs:
		text += " %d " % [item.costs[resource]]
		
	update_text(text, "Buy")
	update_text("Owned: 0", "Owned")
	
	if item.upgrade:
		owned_label.visible = false

func update_text(text: String, label_type: String) -> void:
	if label_type == "Buy":
		buy_label.text = text
	elif label_type == "Owned":
		owned_label.text = text
	else:
		print("Debug from update_text: type unclear")
		return
		
	await get_tree().process_frame
	button_labels.custom_minimum_size = button_labels.get_combined_minimum_size()
	
func _on_update_owned_label(update_item: Item, value: int) -> void:
	if update_item != item:
		return
		
	var text = "Owned: " + str(value)
	
	update_text(text, "Owned")
	
func _on_perchase_button_pressed() -> void:
	Events.perchase_request.emit(item, amount)
	
