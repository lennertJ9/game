extends Control


@export var player_inventory: Inventory

@onready var inventory_slots = $NinePatchRect/InventorySlots
@onready var drag_texture = $DragTexture



var current_holding_item: InventoryItem
var current_holding_item_index: int
var current_holding_item_dropped: bool = true

# draworder probleem te maken met de automatische adding in de tree
func _ready():
	for slot in $NinePatchRect/InventorySlots.get_children():
		slot.drag.connect(_on_drag)
		slot.drop.connect(_on_drop)
		

func _physics_process(delta):
	drag_texture.global_position = get_global_mouse_position()



func _on_drag(item):
	
	current_holding_item = item
	$DragTexture.texture = item.item_texture
	set_physics_process(true)



func _on_drop():
	if !current_holding_item_dropped:
		print('drop')
		for slot in inventory_slots.get_children():
			if slot.hover:
				print(slot)
				slot.update_slot(current_holding_item)
				
				current_holding_item = null
				current_holding_item_index = 0
				
	current_holding_item_dropped = true






func update_inventory():
	for i in player_inventory.inventory_size:
		inventory_slots.get_child(i).update_slot(player_inventory.items[i])




# voegt de slots toe aan de hand van player_inventory.inventor_size
func add_slots():
	player_inventory.items.resize(player_inventory.inventory_size)
	
	if player_inventory:
		for i in player_inventory.inventory_size:
			var slot_scene = preload("res://scenes/UI/inventory/inventory_slot/InventorySlot.tscn").instantiate()
			slot_scene.name = "InventorySlot" + str(i)
			inventory_slots.add_child(slot_scene)

		


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
