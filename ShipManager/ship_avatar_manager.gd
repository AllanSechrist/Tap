extends Node
class_name ShipAvatarManager

const SHIP_AVATAR_SCENE := preload("uid://cmxxsdylfgdr8")

@export var planet: Planet
@export var orbit_radius: float = 150.0
@export var rotation_speed: float = 0.5

var ships: Array[ShipAvatar]
var orbit_rotation: float = 0.0

func _ready() -> void:
	Events.update_ship_avatars.connect(_on_inventory_change)

func _process(delta: float) -> void:
	orbit_rotation += rotation_speed * delta
	update_ship_targets()
	
func add_ship_icon(texture: Texture2D) -> void:
	var ship = SHIP_AVATAR_SCENE.instantiate() as ShipAvatar
	add_child(ship)
	ship.set_icon(texture)
	ship.global_position = planet.global_position
	ships.append(ship)
	update_ship_targets()
	
func update_ship_targets() -> void:
	var count := ships.size()
	if count == 0:
		return
	
	for i in range(count):
		var ship := ships[i]
		var angle := orbit_rotation + (float(i) / count) * TAU
		var offset := Vector2.RIGHT.rotated(angle) * orbit_radius
		ship.target_position = planet.global_position + offset
	
func _on_inventory_change(ship: Ship, new_amount: int) -> void:
	var current_amount := ships.size()
	
	# Add ships
	if new_amount > current_amount:
		for i in range(new_amount - current_amount):
			add_ship_icon(ship.icon)
			
	# Remove ships
	elif new_amount < current_amount:
		for i in range(current_amount - new_amount):
			var old_ship = ships.pop_back()
			old_ship.queue_free()
