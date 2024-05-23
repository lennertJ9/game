# om de source van de items te bepalen: @export var source_Inventory
# 0 --> player_inventory
# 1 --> andere, bijvoorbeeld een chest of drop

# deze integers worden gebruikt bij get_child(source), 
extends Resource

class_name Inventory

signal inventory_changed

@export var items: Array[InventoryItem]
@export var inventory_size: int

func test():
	print("test")
	






