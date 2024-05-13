extends Node2D


@onready var player = $Player
@onready var ui = $UI


func _ready():
	# wanner de healthcomponent health veranderd word
	player.health_component.health_changed.connect(ui.update_health)
	player.mana_component.mana_changed.connect(ui.update_mana)
	
	for ability_manager in player.projectile_manager.get_children():
		ability_manager.ability_used.connect(ui.start_slot_cooldown)
	
	for slot in ui.resource_bar.slots.get_children():
		slot.ability_order_changed.connect(player.projectile_manager.update_slots)




