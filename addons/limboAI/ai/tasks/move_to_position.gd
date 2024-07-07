extends BTAction


@export var target_pos_var:= &"pos"
@export var dir_var:= &"dir"

@export var speed_var = 40
@export var tolerance = 10

func _tick(_delta: float) -> Status:
	var target_pos: Vector2 = blackboard.get_var(target_pos_var, Vector2.ZERO)
	
	var dir = blackboard.get_var(dir_var)
	
	if agent.global_position.distance_to(target_pos) < tolerance:
		agent.move(dir,0)
		print("reachezd")
		return SUCCESS
	else:
		agent.move(dir, speed_var)
		return RUNNING
