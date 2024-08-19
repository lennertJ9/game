extends Node2D


var user_interface_scene = preload("res://scenes/UI/user_interface/user_interface.tscn")


func _ready():
	var user_interface = user_interface_scene.instantiate()
	add_child(user_interface)
