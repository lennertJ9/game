extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("debug"):
		if get_child_count() > 3:
			get_child(-1).queue_free()
			remove_child(get_child(-1))



