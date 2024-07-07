extends BTAction

@export var range_min_in_dir: float = 45.0
@export var range_max_in_dir: float = 120.0

@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"

func _tick(_delta: float) -> Status:
	var dir: Vector2 = random_direction()
	var pos: Vector2 = random_position(dir)
	blackboard.set_var(position_var, pos )
	print(pos)
	return SUCCESS


func random_position(direction):
	var vector: Vector2
	var distance = direction * randi_range(range_min_in_dir, range_max_in_dir) 
	var final_position = (distance + agent.global_position)
	vector = final_position
	return vector


func random_direction():
	var direction = Vector2(randi_range(-1,1), randi_range(-1,1)).normalized()
	blackboard.set_var(dir_var, direction)
	agent.check_sprite_direction(direction)
	return direction
