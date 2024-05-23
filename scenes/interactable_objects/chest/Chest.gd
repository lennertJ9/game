extends StaticBody2D

signal open_chest
signal close_chest

@onready var sprite_2d = $Sprite2D
@onready var inventory_chest = $InventoryChest
@export var inventory: Inventory


var player_in_range: bool = false





func _on_control_gui_input(event):
	if event.is_pressed() and event.button_index==1 and player_in_range:
		open_chest.emit(inventory)



func _on_control_mouse_entered():
	sprite_2d.frame = 1


func _on_control_mouse_exited():
	sprite_2d.frame = 0




func _on_player_range_body_entered(body):
	player_in_range = true


func _on_player_range_body_exited(body):
	player_in_range = false
	close_chest.emit()
