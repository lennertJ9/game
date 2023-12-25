extends CharacterBody2D


@export var speed = 100
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var animation_tree = $AnimationTree

@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/HandLeft/Weapon

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
		
		if movement_direction.y < 0: # up
			is_up = true
			animation_player.play("RUN_FRONT")
		else: 
			is_up = false # down
			animation_player.play("RUN_FRONT")

	if event.is_action_pressed("do_something"):
		pass

func _process(delta):
	var direction = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-3) + direction * 5
	
	if direction.x < 0:
		$Visuals.scale.x = -1
		hand_left.rotation_degrees = rad_to_deg(direction.dot(Vector2.DOWN))
		
	else: 
		$Visuals.scale.x = 1
		hand_left.rotation_degrees = rad_to_deg(direction.dot(Vector2.DOWN))
	print(rad_to_deg(direction.dot(Vector2.UP)))
	
	
	hand_left.global_position = target_position
	

func _physics_process(_delta):
	velocity = movement_direction * speed
	
	
	if position.distance_to(target) > 1:
		move_and_slide()

	else:
		is_running = false
		if is_up:
			animation_player.play("IDLE_FRONT")
		else:
			animation_player.play("IDLE_FRONT")



func emit_dust_particles():
	var particle = preload("res://scenes/player/visuals/RunDust.tscn").instantiate()
	var world = get_tree().get_first_node_in_group("world")
	particle.global_position = global_position
	particle.play()
	world.add_child(particle)
	
