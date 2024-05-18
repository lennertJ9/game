extends Control

signal drag
signal drop
signal swap


@export var current_item: InventoryItem

@onready var slot_texture = $SlotTexture
@onready var item_texture = $ItemTexture


var selected: bool = false
var hover: bool = false

func _ready():
	if current_item:
		item_texture.texture = current_item.item_texture




func update_slot(item: InventoryItem):
	if item:
		current_item = item
		item_texture.texture = item.item_texture
	else:
		current_item = item
		item_texture.texture = null



#func _physics_process(delta):
	#if selected:
		#$ItemTexture.global_position = lerp($ItemTexture.global_position, get_global_mouse_position(), 50 * delta) - Vector2(16,16)
	#else:
		#$ItemTexture.position = lerp($ItemTexture.position, $SlotTexture.position + Vector2(2,2), 25 * delta)
		#if $ItemTexture.position == $SlotTexture.position + Vector2(2,2):
			#set_physics_process(false)



#func _on_gui_input(event):
	#if Input.is_action_just_pressed("left_click") and current_item:
		#selected = true
		#set_physics_process(true)

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			#selected = false



func _get_drag_data(at_position):
	print("drag")
		


func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	print("drop")




