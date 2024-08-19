extends Resource 


class_name InventoryItem


@export var name: String
@export var texture: Texture
@export var stackable: bool 
@export var quantity: int


func _init():
	print("init")


