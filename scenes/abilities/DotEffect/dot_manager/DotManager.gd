extends Node2D

signal ability_used

@export var ability_scene: PackedScene
var cooldown: float = 2.0
var input: String


func _input(event):
	if event.is_action_pressed(input):
		use()
		ability_used.emit(cooldown)


func use():
	var ability = ability_scene.instantiate()
	ability.global_position = get_global_mouse_position()
	ability.name = "DotEffect"
	
	add_child(ability)
