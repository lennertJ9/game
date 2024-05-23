extends NinePatchRect

signal invalid_drop
signal drop

#@export var inventory_id: int
@export var inventory_resource: Inventory


@onready var inventory_slots = $InventorySlots
@onready var preview = $Control/Preview

var current_drag_index



func _ready():
	load_inventory(inventory_resource)
	set_physics_process(false)
	
	for slot in inventory_slots.get_children():
		slot.drag.connect(on_drag)



func on_drag(item: InventoryItem, index):
	current_drag_index = index
	get_tree().get_first_node_in_group('UI').inventory_manager.make_preview(item.item_texture)



func _can_drop_data(at_position, data):
	return true



func _drop_data(at_position, data):
	inventory_slots.get_child(current_drag_index).update_slot(data)
	


func load_inventory(inventory):
	if inventory:
		inventory_resource = inventory
		var i = 0
		for item in inventory.items:
			inventory_slots.get_child(i).update_slot(item)
			i += 1


