extends Control


@onready var inventory: InventoryUI = $Inventory
@onready var chest: InventoryUI = $Chest

var is_inventory_open: bool = false
var dragging: bool = false
var dragging_item: InventoryItem
var dragging_slot: Control                          
var preview: TextureRect



func _ready():
	inventory.visible = false
	chest.visible = false
	
	set_process(false)
	for slot in inventory.slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.stack.connect(on_stack)
		slot.swap.connect(on_swap)
		
	for slot in chest.slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)
		slot.stack.connect(on_stack)
		slot.swap.connect(on_swap)



func open():
	if is_inventory_open:
		inventory.visible = false
		is_inventory_open = false
	else:
		inventory.visible = true
		is_inventory_open = true




func _input(event):
	if event.is_action_pressed("debug"):
		pass



func on_drag(inventory_item: InventoryItem, slot: Control):
	slot.update_slot(null)
	dragging = true
	dragging_item = inventory_item
	dragging_slot = slot




func on_drop(inventory_item: InventoryItem, slot: Control):
	slot.update_slot(inventory_item)
	remove_child(preview)
	dragging = false
	dragging_item = null
	dragging_slot = null



func on_stack(inventory_item: InventoryItem, slot: Control):
	inventory_item.quantity += dragging_item.quantity
	slot.update_slot(inventory_item)



func on_swap(inventory_item: InventoryItem, slot: Control):
	dragging_slot.update_slot(inventory_item)
	slot.update_slot(dragging_item)
	


func _can_drop_data(at_position, data):
	return true



func _drop_data(at_position, data):
	if dragging_slot:
		dragging_slot.update_slot(dragging_item)
