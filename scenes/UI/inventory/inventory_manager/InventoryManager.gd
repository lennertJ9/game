extends Control


@onready var player_inventory = $PlayerInventory
@onready var chest_inventory = $ChestInventory
@onready var preview = $Preview
@onready var preview_texture = $Preview/PreviewTexture

var player_inventory_resource: Inventory
var chest_inventory_resource: Inventory

var drag: bool
var player_inventory_open: bool
var chest_inventory_open: bool

var current_dragging_item: InventoryItem
var current_dragging_index: int
var current_dragging_source: int


func _ready():
	set_physics_process(false)
	
	player_inventory_resource = player_inventory.inventory_resource
	
	
	for slot in player_inventory.inventory_slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.swap.connect(on_swap)
		
	for slot in chest_inventory.inventory_slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.swap.connect(on_swap)

	player_inventory.close_button.connect(close_player_inventory)
	player_inventory.invalid_drop.connect(invalid_drop)
	
	chest_inventory.close_button.connect(close_chest)
	chest_inventory.invalid_drop.connect(invalid_drop)



func _physics_process(delta):
	preview.position = lerp(preview.position,get_global_mouse_position(), 15*delta)


func _input(event):
	if event.is_action_pressed("inventory"):
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
		chest_inventory_resource = inventory
		chest_inventory.load_inventory(inventory)
		chest_inventory.open()



func close_chest():
	if chest_inventory_open:
		chest_inventory_open = false
		chest_inventory.close()


func open_player_inventory():
	player_inventory.open()
	


func close_player_inventory():
	player_inventory.close()
	print("close")


func on_drag(data, index,source): # emit van slot drag functie
	make_preview(data.item_texture)
	current_dragging_item = data
	current_dragging_index = index
	current_dragging_source = source



func on_drop(item: InventoryItem, index: int, source: int): # emit van slot drop functie
	var drop_slot = get_child(source).inventory_slots.get_child(index)
	drop_slot.update_slot(item)
	update_inventory_resource(item, index, source)
	update_inventory_resource(null, current_dragging_index, current_dragging_source)



func on_swap(item: InventoryItem, index: int, source: int): # emit van slot drop functie
	var drop_slot = get_child(source).inventory_slots.get_child(index) # slot waar we droppen
	var drag_slot = get_child(current_dragging_source).inventory_slots.get_child(current_dragging_index) # slot waarvan we draggen
	
	drop_slot.update_slot(current_dragging_item)
	update_inventory_resource(current_dragging_item, index, source)
	
	drag_slot.update_slot(item)
	update_inventory_resource(item, current_dragging_index, current_dragging_source)



func update_inventory_resource(item: InventoryItem, index: int, source: int):
	get_child(source).inventory_resource.items[index] = item


func invalid_drop(item: InventoryItem):
	var slot = get_child(current_dragging_source).inventory_slots.get_child(current_dragging_index)
	slot.update_slot(item)
	update_inventory_resource(item, current_dragging_index, current_dragging_source)

