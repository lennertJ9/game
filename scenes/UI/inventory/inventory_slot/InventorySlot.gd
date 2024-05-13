extends Control

signal drag
signal swap

@export var current_item: InventoryItem

@onready var slot_texture = $SlotTexture
@onready var item_texture = $ItemTexture



func _ready():
	if current_item:
		item_texture.texture = current_item.item_texture
	print("index: ", get_index())

func update_slot(item: InventoryItem):
	if item:
		current_item = item
		item_texture.texture = item.item_texture
	else:
		current_item = item
		item_texture.texture = null


func make_preview():
	var preview = Control.new()
	preview.scale = Vector2(4,4)
	var preview_texture = TextureRect.new()
	preview_texture.texture = current_item.item_texture
	preview_texture.position = Vector2(-8,-8)
	preview.add_child(preview_texture)
	return preview


func _get_drag_data(at_position):
	if current_item:
		set_drag_preview(make_preview())
		
		var data = current_item
		
		drag.emit(current_item,get_index())
		
		update_slot(null)
		return data


func _can_drop_data(at_position, data):
	if 5==5:
		return true


func _drop_data(at_position, data):
	if !current_item:
		update_slot(data)
	else:
		swap.emit(current_item, get_index())
