extends Control


@export var player_inventory: Inventory

@onready var inventory_slots = $NinePatchRect/InventorySlots

var current_holding_item: InventoryItem
var current_holding_item_index: int

# draworder probleem te maken met de automatische adding in de tree
func _ready():
	pass



func _on_drag(item, index):
	current_holding_item = item
	current_holding_item_index = index



func _on_swap(item, index):
	swap_items(item, index)



func update_inventory():
	for i in player_inventory.inventory_size:
		inventory_slots.get_child(i).update_slot(player_inventory.items[i])



func swap_items(item,index):
	print("swapping")
	inventory_slots.get_child(index).update_slot(current_holding_item)
	inventory_slots.get_child(current_holding_item_index).update_slot(item)







# voegt de slots toe aan de hand van player_inventory.inventor_size
func add_slots():
	player_inventory.items.resize(player_inventory.inventory_size)
	
	if player_inventory:
		for i in player_inventory.inventory_size:
			var slot_scene = preload("res://scenes/UI/inventory/inventory_slot/InventorySlot.tscn").instantiate()
			slot_scene.name = "InventorySlot" + str(i)
			inventory_slots.add_child(slot_scene)
			inventory_slots.get_child(i).drag.connect(_on_drag)
			inventory_slots.get_child(i).swap.connect(_on_swap)
		


# voorlopig een slot een item geven
func add_items():
	var health_potion = preload("res://resources/inventory_items/consumables/healing_potion.tres")
	var mana_potion = preload("res://resources/inventory_items/consumables/mana_potion.tres")
	inventory_slots.get_child(5).update_slot(health_potion)
	inventory_slots.get_child(2).update_slot(mana_potion)




func _input(event):
	if Input.is_action_just_pressed("debug"):
		
		for slot in inventory_slots.get_children():
			slot.rest_point = slot.position
			print("position ",slot.position)
			print("---------------")
