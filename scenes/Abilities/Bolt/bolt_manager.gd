extends Node2D

var bolt_instance = preload("res://scenes/Abilities/Bolt/bolt.tscn")

func shoot(shoot_direction,position):
	var bolt = bolt_instance.instantiate()
	var world = get_tree().get_first_node_in_group("world")
	bolt.global_position = position
	bolt.movement_direction = shoot_direction
	bolt.angle = rad_to_deg(shoot_direction.angle())
	world.add_child(bolt)
	
	
	
