extends Control

signal drag
signal drop

@export var inventory_item: InventoryItem

@onready var slot_texture = $SlotTexture
@onready var item_texture = $ItemTexture


# Called when the node enters the scene tree for the first time.
func _ready():
	if inventory_item:
		item_texture.texture = inventory_item.item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_slot(item: InventoryItem):
	if item:
		inventory_item = item
		item_texture.texture = item.item_texture
		$AnimationPlayer.play("big_drop")
	else:
		inventory_item = null
		item_texture.texture = null


func _get_drag_data(at_position):
	$AnimationPlayer.play("drop")
	if inventory_item:
		var data = inventory_item
		update_slot(null)
		drag.emit(data, get_index())
		return data


func _can_drop_data(at_position, data):
	$AnimationPlayer.play("drop")
	if data is InventoryItem:
		return true



func _drop_data(at_position, data):
	drop.emit()
	update_slot(data)
	


