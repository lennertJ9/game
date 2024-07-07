extends Node
class_name state

var active: bool = false


func _ready():
	set_physics_process(false)



func enter():
	active = true
	set_physics_process(true)
	initialize()



func exit():
	active = false
	set_physics_process(false)
	finalize()



func initialize():
	pass



func finalize():
	pass


