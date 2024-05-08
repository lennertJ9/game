extends Node
class_name StateManager

@export var starting_state: Node
var current_state: Node

func _ready():
	change_state(starting_state)


func change_state(new_state: Node):
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()

func disable_current_process():
	current_state.exit()
	await get_tree().create_timer(1).timeout
	current_state.enter()
