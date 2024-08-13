extends Node2D


@export var ability_scene: PackedScene


func _input(event):
	if event.is_action_pressed("left_click"):
		use()


func use():
	var ability = ability_scene.instantiate()
	ability.global_position = get_global_mouse_position()
	ability.name = "DotEffect"
	owner.add_child(ability)
