extends Node2D


@export var bolt_instance: PackedScene
@export var png: CompressedTexture2D = preload("res://assets/UI/abilities/bolt_icon,.png")

func shoot(shoot_direction,position):
	var bolt = bolt_instance.instantiate()
	var world = get_tree().get_first_node_in_group("world")
	bolt.global_position = position
	bolt.movement_direction = shoot_direction
	bolt.angle = rad_to_deg(shoot_direction.angle())
	world.add_child(bolt)
	
	
	
