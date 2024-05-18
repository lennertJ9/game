extends NinePatchRect


@onready var inventory_slots = $InventorySlots
@onready var preview = $Preview

var current_drag_index


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
	for slot in inventory_slots.get_children():
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	preview.global_position = get_global_mouse_position() - Vector2(30,30)



func on_drag(item: InventoryItem, index):
	preview.texture = item.item_texture
	current_drag_index = index
	set_physics_process(true)
	


func on_drop():
	preview.texture = null
	set_physics_process(false)

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			preview.texture = null
			print("release item")


func _can_drop_data(at_position, data):
	return true


func _drop_data(at_position, data):
	inventory_slots.get_child(current_drag_index).update_slot(data)


