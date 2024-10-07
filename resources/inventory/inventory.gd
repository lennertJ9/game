# om de source van de items te bepalen: @export var source_Inventory
# 0 --> player_inventory
# 1 --> andere, bijvoorbeeld een chest of drop

# deze integers worden gebruikt bij get_child(source), 
extends Resource

class_name Inventory

signal inventory_changed

@export var items: Array[InventoryItem]
<<<<<<< Updated upstream:resources/inventory/inventory.gd
@export var inventory_size: int









=======
>>>>>>> Stashed changes:resources/inventory/scripts/inventory.gd
