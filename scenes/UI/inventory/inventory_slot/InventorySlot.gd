extends Control

signal drag
signal swap

@export var current_item: InventoryItem

@onready var slot_texture = $SlotTexture
@onready var item_texture = $ItemTexture



var selected: bool = false
var rest_point: Vector2 


func _ready():
	#rest_point = $ItemTexture.position
	#print(rest_point)
	
	if current_item:
		item_texture.texture = current_item.item_texture






func update_slot(item: InventoryItem):
	if item:
		current_item = item
		item_texture.texture = item.item_texture
	else:
		current_item = item
		item_texture.texture = null


#func make_preview():
	#print("making preview")
	#var preview = Control.new()
	#preview.scale = Vector2(5,5)
	#var preview_texture = TextureRect.new()
	#preview_texture.texture = current_item.item_texture
	#preview_texture.position = Vector2(-8,-8)
	#
	#preview.add_child(preview_texture)
	#return preview


#func _get_drag_data(at_position):
	#if current_item:
		#set_drag_preview(make_preview())
		#
		#var data = current_item
		#
		#drag.emit(current_item,get_index())
		#
		#update_slot(null)
		#return data
#
#
#func _can_drop_data(at_position, data):
	#if 5==5:
		#return true
#
#
#func _drop_data(at_position, data):
	#if !current_item:
		#update_slot(data)
	#else:
		#swap.emit(current_item, get_index())



func _physics_process(delta):
	if selected:
		$ItemTexture.global_position = lerp($ItemTexture.global_position, get_global_mouse_position(), 25 * delta) - Vector2(16,16)
	else:
		$ItemTexture.global_position = lerp($ItemTexture.global_position, rest_point, 10 * delta)


func _on_gui_input(event):
	if Input.is_action_just_pressed("left_click"):
		selected = true


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
