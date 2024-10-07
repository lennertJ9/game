extends Control
class_name InventoryUI


@export var inventory_resource: Inventory
@onready var slots = $Slots
var inventory_slot_scene = preload("res://scenes/UI/inventory/inventory_slot/InventorySlot.tscn")



func _ready():
	var i = 1
	for item in inventory_resource.items:
		var inventory_slot = inventory_slot_scene.instantiate()
		inventory_slot.update_resource.connect(update_resource)
		inventory_slot.name = "InventorySlot_" + str(i)
		i += 1
		if item:
			inventory_slot.item = item
		slots.add_child(inventory_slot)
		
	call_deferred("update_rect")



func update_rect():
	size = slots.size + Vector2(10,10)



func update_resource(inventory_item: InventoryItem, index: int):
	inventory_resource.items[index] = inventory_item
	
