extends Node2D


@export var player: Player
@export var ui: UserInterface 
@onready var chests = $Chests
@onready var scene_transition = $SceneTransition



func _ready():
	
	connect_chest()
	connect_ability_bar()
	

# verbind het click signal met de inventory_manager
func connect_chest():
	for chest in chests.get_children():
		chest.open_chest.connect(ui.inventory_manager.open_chest)
		chest.close_chest.connect(ui.inventory_manager.close_chest)


func connect_ability_bar():
	for slot in ui.ability_bar.slots:
		slot.drag.connect(player.ability_manager.remove_manager)
		slot.drop.connect(player.ability_manager.set_ability)
	player.ability_manager.ability_use.connect(ui.ability_bar.start_cooldown)



func _on_exit_1_body_entered(body):
	MapManager.change_map(MapManager.elder_wood)
