extends Control

signal drag
signal swap
signal drop
signal stack
signal update_resource


@onready var item_texture = $ItemTexture
@onready var amount_label = $AmountLabel

var item: InventoryItem
var item_amount: int



func _ready():
	if item:
		update_slot(item)
	else:
		update_slot(null)
	


func update_slot(inventory_item: InventoryItem):
	if inventory_item:
		item = inventory_item
		item_texture.texture = inventory_item.texture
		update_resource.emit(inventory_item, get_index())
		update_label(inventory_item)
	else:
		item = null
		item_texture.texture = null
		update_resource.emit(null, get_index())
		update_label(null)



func _get_drag_data(at_position):
	if item:
		var data = item
		drag.emit(data, self)
		var user_interface = get_tree().get_first_node_in_group("UI")
		user_interface.preview_manager.make_preview(data.texture)
		return data



func _can_drop_data(at_position, data):
	if data is InventoryItem:
		return true



func _drop_data(at_position, data):
	if item:
		if item.name == data.name and item.stackable:
			stack.emit(item,self)
		else:
			swap.emit(item,self)
	else:
		drop.emit(data,self)



func update_label(inventory_item: InventoryItem):
	if inventory_item:
		amount_label.text = str(inventory_item.quantity)
		amount_label.visible = true
	else:
		amount_label.visible = false



func _gui_input(event):
	var health_component: HealthComponent = get_tree().get_first_node_in_group("player").health_component
	if event.is_action_pressed("right_click") and item:
		item.use(health_component)



