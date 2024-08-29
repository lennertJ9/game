extends CanvasLayer
class_name UserInterface

@export var player_stats : Stats


@onready var preview_manager: Control = $PreviewManager
@onready var ability_menu: Control = $AbilityMenu
@onready var ability_bar: Control = $AbilityBar
@onready var inventory_manager: Control = $InventoryManager



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		inventory_manager.open()
	if event.is_action_pressed("ability_menu"):
		ability_menu.open()





