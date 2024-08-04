extends CharacterBody2D


@export var stats: Stats

@onready var animation_player = $AnimationPlayer

@onready var state_manager: StateManager = $StateManager
@onready var wander: state = $StateManager/Wander
@onready var chase: state = $StateManager/Chase
@onready var attack = $StateManager/Attack


@onready var nav_agent = $NavigationAgent2D





func check_sprite_direction(direction: Vector2):
	if direction.x < 0:
		$Visuals.scale.x = -1
	else:
		$Visuals.scale.x = 1


func _input(event):
	if event.is_action_pressed("debug"):
		print("debug")
		var anim: Animation = animation_player.get_animation("running")
		var track = anim.find_track("Visuals/Sword:rotation",Animation.TYPE_VALUE)
		print(track)
		anim.track_set_enabled(track, false)




func _on_area_2d_body_entered(body):
	chase.target = body
	state_manager.change_state(chase)



func _on_attack_range_body_entered(body):
	state_manager.change_state(attack)
	await animation_player.animation_finished
	state_manager.change_state(chase)
