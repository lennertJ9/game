extends Node2D

var user_interface = preload("res://scenes/UI/user_interface/user_interface.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(user_interface.instantiate())
