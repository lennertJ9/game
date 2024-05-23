extends Control

var player_inventory_resource: Inventory
var chest_inventory_resource: Inventory



@onready var player_inventory = $PlayerInventory
@onready var chest_inventory = $ChestInventory


@onready var preview = $Preview
@onready var preview_texture = $Preview/PreviewTexture

var drag: bool
var player_inventory_open: bool


func _ready():
	set_physics_process(false)
	for slot in player_inventory.inventory_slots.get_children():
		slot.drop.connect(on_drop)
	for slot in chest_inventory.inventory_slots.get_children():
		slot.drop.connect(on_drop)



func _physics_process(delta):
	preview.position = lerp(preview.position,get_global_mouse_position(), 15*delta)


func _input(event):
	if event.is_action_pressed("inventory"):
		if player_inventory_open:
			player_inventory.visible = false
			player_inventory_open = false
		else:
			player_inventory.visible = true
			player_inventory_open = true

	if event is InputEventMouseButton and drag:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			set_physics_process(false)
			preview_texture.texture = null
			drag = false



func make_preview(texture: Texture2D):
	preview.position = get_global_mouse_position()
	drag = true
	preview_texture.texture = texture
	set_physics_process(true)



func open_chest(inventory: Inventory):
	print("open")
	chest_inventory.visible = true
	chest_inventory.load_inventory(inventory)


func close_chest():
	print("i need to close")
	chest_inventory.visible = false
	



func on_drop():
	print("drop")
