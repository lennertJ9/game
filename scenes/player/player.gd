extends CharacterBody2D


@export var speed = 100
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var animation_tree = $AnimationTree


# walking system
var movement_direction: Vector2
var target = position
var is_running
var is_up


func _input(event):
	if event.is_action_pressed("right_click"):
		is_running = true
		
		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		
		if movement_direction.x < 0: #links
			visuals.scale.x = -1
		else:
			visuals.scale.x = 1      #rechts
			
		if movement_direction.y < 0: # up
			is_up = true
			animation_player.play("Run_Back")
		else: 
			is_up = false # down
			animation_player.play("Run_Front")
#		print(is_up)
		
		
		



func _process(delta):
	pass
	

func _physics_process(_delta):
	velocity = movement_direction * speed
	
	
	if position.distance_to(target) > 5:
		move_and_slide()

	else:
		is_running = false
		if is_up:
			animation_player.play("Idle_Back")
		else:
			animation_player.play("Idle_Front")



func emit_dust_particles():
	var particle = preload("res://scenes/player/visuals/RunDust.tscn").instantiate()
	var world = get_tree().get_first_node_in_group("world")
	particle.global_position = global_position
	particle.play()
	world.add_child(particle)
	
