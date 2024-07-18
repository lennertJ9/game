extends Node
class_name state

var is_active: bool = false


func _ready():
	set_physics_process(false)



func enter():
	is_active = true
	initialize()
	set_physics_process(true)
	set_process(true)



func exit():
	is_active = false
	finalize()
	set_physics_process(false)
	set_process(false)



func initialize():
	pass



func finalize():
	pass


