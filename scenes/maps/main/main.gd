extends Node2D


@export var player: Player
@export var ui: UserInterface 
@onready var chests = $Chests
@onready var scene_transition = $SceneTransition


 
func _ready():
	pass





func _on_exit_1_body_entered(body):
	MapManager.change_map(MapManager.elder_wood,-120,60)
	

