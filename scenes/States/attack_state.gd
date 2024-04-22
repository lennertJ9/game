extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)



func enter():
	set_physics_process(true)
	update_direction()
	$Timer.start()
	
func exit():
	set_physics_process(false)
	$Timer.stop()

func update_direction():
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	owner.movement_direction = owner.global_position.direction_to(player_pos)

func _on_timer_timeout():
	update_direction()
