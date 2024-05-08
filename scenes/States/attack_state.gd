extends Node2D






func _ready():
	set_physics_process(false)

	

func _physics_process(delta):
	
	owner.movement_direction = (owner.navigation_agent_2d.get_next_path_position() - owner.global_position).normalized()
	
	

func enter():
	set_physics_process(true)
	$Timer.start()
	
func exit():
	set_physics_process(false)
	$Timer.stop()



func _on_timer_timeout():
	owner.navigation_agent_2d.target_position = get_tree().get_first_node_in_group("player").global_position
	
	
