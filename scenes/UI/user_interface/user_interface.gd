extends CanvasLayer
class_name UserInterface

@export var player_stats : Stats


@onready var preview_manager = $PreviewManager
@onready var ability_menu = $AbilityMenu
@onready var ability_bar = $AbilityBar
@onready var inventory_manager = $InventoryManager



func _input(event):
	if event.is_action_pressed("inventory"):
		inventory_manager.open()
	if event.is_action_pressed("ability_menu"):
		ability_menu.open()





