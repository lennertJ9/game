extends Control

var player_inventory_resource: Inventory
var chest_inventory_resource: Inventory



@onready var player_inventory = $PlayerInventory
@onready var chest_inventory = $ChestInventory

@onready var preview = $Preview
@onready var preview_texture = $Preview/PreviewTexture

var drag: bool
var player_inventory_open: bool
var chest_inventory_open: bool

var current_dragging_item: InventoryItem
var current_dragging_index: int


func _ready():
	set_physics_process(false)
	for slot in player_inventory.inventory_slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.swap.connect(on_swap)
		
	for slot in chest_inventory.inventory_slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.swap.connect(on_swap)

	player_inventory.close_button.connect(close_player_inventory)
	chest_inventory.close_button.connect(close_chest)


func _physics_process(delta):
	preview.position = lerp(preview.position,get_global_mouse_position(), 15*delta)


func _input(event):
	if event.is_action_pressed("inventory"):
		if player_inventory_open:
			close_player_inventory()
		else:
			open_player_inventory()


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
	if !chest_inventory_open:
		chest_inventory_open = true
		chest_inventory.open()
		chest_inventory.load_inventory(inventory)


func close_chest():
	if chest_inventory_open:
		chest_inventory_open = false
		chest_inventory.close()


func open_player_inventory():
	player_inventory_open = true
	player_inventory.open()


func close_player_inventory():
	player_inventory_open = false
	player_inventory.close()
	

func on_drag(data, index,source):
	make_preview(data.item_texture)
	current_dragging_item = data
	current_dragging_index = index



func on_drop(data, index, source):
	get_child(source).inventory_slots.get_child(index).update_slot(data)



func on_swap(data, index, source):
	print("swap")
