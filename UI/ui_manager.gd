extends CanvasLayer
class_name UIManager

@onready var hud: UI = $HUD
@onready var shop_ui: ShopUI = $ShopUI

var current_menu: Control = null

func _ready() -> void:
	Events.toggle_shop_menu.connect(toggle_shop)
	close_all_menus()

func close_all_menus() -> void:
	shop_ui.hide()
	
	current_menu = null

func open_menu(menu: Control) -> void:
	if current_menu != null:
		current_menu.hide()
		
	current_menu = menu
	current_menu.show()
	
func toggle_shop() -> void:
	if current_menu == shop_ui:
		close_all_menus()
	else:
		open_menu(shop_ui)
