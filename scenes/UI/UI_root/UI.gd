extends CanvasLayer
class_name UserInterface

@export var player_stats : statistic


@onready var resource_bar = $ResourceBar
@onready var icon_bar = $IconBar
@onready var inventory_manager = $InventoryManager
@onready var ability_menu = $AbilityMenu
@onready var preview_manager = $PreviewManager
@onready var ability_bar = $AbilityBar

var is_inventory_open: bool = false
var is_ability_bar_open: bool = false


func _ready():
	#update_health()
	#update_mana()
	#update_properties()
	
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



#func update_health():
	#resource_bar.update_health(player_stats.current_health)
	#resource_bar.health_label.text = str(player_stats.current_health) + "/" + str(player_stats.max_health)
#
#
#
#func update_mana():
	#resource_bar.update_mana(player_stats.current_mana) 
	#resource_bar.mana_label.text = str(player_stats.current_mana) + "/" + str(player_stats.max_mana)
#
#
#
#func update_properties():
	#resource_bar.health_bar.max_value = player_stats.max_health
	#resource_bar.mana_bar.max_value = player_stats.max_mana
#
#
#
#func start_slot_cooldown(index):
	#resource_bar.slots.get_child(index).start_cooldown()
#
#
#
#func _on_update_resources_timeout():
	#update_mana()
	#update_health()
#
#
#
#func _on_life_mouse_entered():
	#$HealthLable.visible = true
	#
#
#
#func _on_life_mouse_exited():
	#$HealthLable.visible = false
#
#
#
#func _on_mana_mouse_entered():
	#$ManaLable.visible = true
#
#
#
#func _on_mana_mouse_exited():
	#$ManaLable.visible = false
#


func connect_signals():
	icon_bar.ability_menu_button.connect(open_ability_menu)
	icon_bar.inventory_button.connect(open_inventory)
	
	for slot in ability_bar.slots:
		slot.drag.connect(preview_manager.make_preview)
	
	for slot in ability_menu.slots:
		slot.drag.connect(preview_manager.make_preview)
