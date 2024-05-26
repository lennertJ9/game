extends CanvasLayer
class_name UserInterface

@export var player_stats : statistic


@onready var resource_bar = $ResourceBar
@onready var icon_bar = $IconBar
@onready var inventory_manager = $InventoryManager

var is_inventory_open: bool = false


func _ready():
	update_health()
	update_mana()
	update_properties()
	
	icon_bar.inventory_button.connect(inventory_manager.open_player_inventory)





func update_health():
	resource_bar.update_health(player_stats.current_health)
	resource_bar.health_label.text = str(player_stats.current_health) + "/" + str(player_stats.max_health)



func update_mana():
	resource_bar.update_mana(player_stats.current_mana) 
	resource_bar.mana_label.text = str(player_stats.current_mana) + "/" + str(player_stats.max_mana)



func update_properties():
	resource_bar.health_bar.max_value = player_stats.max_health
	resource_bar.mana_bar.max_value = player_stats.max_mana



func start_slot_cooldown(index):
	resource_bar.slots.get_child(index).start_cooldown()



func _on_update_resources_timeout():
	update_mana()
	update_health()



func _on_life_mouse_entered():
	$HealthLable.visible = true
	


func _on_life_mouse_exited():
	$HealthLable.visible = false



func _on_mana_mouse_entered():
	$ManaLable.visible = true



func _on_mana_mouse_exited():
	$ManaLable.visible = false




