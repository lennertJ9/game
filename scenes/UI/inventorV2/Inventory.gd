extends NinePatchRect

signal invalid_drop

#@export var inventory_id: int
@export var inventory: Inventory


@onready var inventory_slots = $InventorySlots
@onready var preview = $Control/Preview

var current_drag_index



func _ready():
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


