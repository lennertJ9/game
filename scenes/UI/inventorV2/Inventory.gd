extends NinePatchRect


signal invalid_drop
signal drop
signal close_button

@export var inventory_source: int
@export var inventory_resource: Inventory


@onready var inventory_slots = $InventorySlots
@onready var preview = $Control/Preview
@onready var animation_player = $AnimationPlayer
@onready var texture_button = $TextureButton



func _ready():
	load_inventory(inventory_resource)
	set_physics_process(false)



func _can_drop_data(at_position, data):
	return true



#func _drop_data(at_position, data):
	#inventory_slots.get_child(current_drag_index).update_slot(data)


func load_inventory(inventory):
	if inventory:
		inventory_resource = inventory
		var i = 0
		for item in inventory.items:
			inventory_slots.get_child(i).update_slot(item)
			i += 1



func open():
	print("open chesttttt")
	animation_player.play("open")
	visible = true



func close():
	animation_player.play("close_button")
	await get_tree().create_timer(0.3).timeout



func _on_texture_button_pressed():
	close_button.emit()
	
