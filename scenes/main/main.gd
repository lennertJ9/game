extends Node2D


@onready var player = $Player
@onready var ui: UserInterface = $UI
@onready var chests = $Chests


func _ready():
	print("skill")
	# wanner de healthcomponent health veranderd word
	#player.health_component.health_changed.connect(ui.update_health)
	#player.mana_component.mana_changed.connect(ui.update_mana)
	
	

	connect_chest()


# verbind het click signal met de inventory_manager
func connect_chest():
	for chest in chests.get_children():
		chest.open_chest.connect(ui.inventory_manager.open_chest)
		chest.close_chest.connect(ui.inventory_manager.close_chest)


