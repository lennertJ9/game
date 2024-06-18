extends CanvasLayer
class_name UserInterface

@export var player_stats : statistic


@onready var resource_bar = $ResourceBar
@onready var inventory_manager = $InventoryManager
@onready var ability_menu = $AbilityMenu
@onready var preview_manager = $PreviewManager
@onready var ability_bar = $AbilityBar
@onready var scene_transition = $SceneTransition
@onready var icon_bar = $IconBar



var is_inventory_open: bool = false
var is_ability_bar_open: bool = false


func _ready():
	connect_signals()
	



func open_inventory():
	if !is_inventory_open:
		is_inventory_open = true
		$InventoryManager.open_player_inventory()
		
		if is_ability_bar_open:
			ability_menu.close()
			is_ability_bar_open = false

	else:
		is_inventory_open = false
		$InventoryManager.close_player_inventory()



func open_ability_menu():
	if !is_ability_bar_open:
		ability_menu.open()
		is_ability_bar_open = true
		
		if is_inventory_open:
			inventory_manager.close_player_inventory()
			is_inventory_open = false
			
	else:
		ability_menu.close()
		is_ability_bar_open = false



func connect_signals():
	icon_bar.ability_menu_button.connect(open_ability_menu)
	icon_bar.inventory_button.connect(open_inventory)
	
	for slot in ability_bar.slots:
		slot.drag.connect(preview_manager.make_preview)
	
	for slot in ability_menu.slots:
		slot.drag.connect(preview_manager.make_preview)


func hide_ui():
	icon_bar.visible = false
	ability_bar.visible = false


