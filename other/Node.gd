extends Node
class_name StateManager

@export var starting_state: state

var current_state: state


func _ready():
	change_state(starting_state)


func change_state(new_state: Node):
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()
	


