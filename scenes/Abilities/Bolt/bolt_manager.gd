extends Node2D

var bolt_instance = preload("res://scenes/Abilities/Bolt/bolt.tscn")

func shoot():
	var bolt = bolt_instance.instantiate()
	var world = get_tree().get_first_node_in_group("world")
	bolt.global_position = Vector2(0,0)
	world.add_child(bolt)
	
	
	
