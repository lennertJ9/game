extends CharacterBody2D



@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/HandLeft/Weapon

# walking system
@export var speed = 80
var current_speed = 80
var movement_direction: Vector2
var target = position
var is_running
var is_moving_right: bool
var is_moving_left: bool


func _input(event):
	if event.is_action_pressed("right_click"):
		is_running = true

		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)

		animation_player.play("RUN")

		if movement_direction.x > 0:
			is_moving_right = true
			is_moving_left = false
			$Visuals.scale.x = 1
		else:
			is_moving_right = false
			is_moving_left = true
			$Visuals.scale.x = -1


	if event.is_action_pressed("do_something"):
		
		#var tween = create_tween()
		#tween.tween_property(hand_left,"rotation_degrees", + 15, .25).set_trans(Tween.TRANS_BACK)
		#tween.tween_property(hand_left,"rotation_degrees", -10, .15)
		var shoot_direction = (get_global_mouse_position() - $Visuals/Marker2D.global_position).normalized()
		print(shoot_direction)
		$BoltManager.shoot(shoot_direction,$Visuals/Marker2D.global_position)
		$AnimationPlayer2.play("ATTACK_LEFT_FRONT")
		if shoot_direction.x > 0:
			$Visuals.scale.x = 1
		else:
			$Visuals.scale.x = -1

func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7
	
# weapon rotation -----------------------------------------------------------------------
	#if direction_to_mouse.x < 0:
		#$Visuals.scale.x = -1
		#hand_left.rotation_degrees = rad_to_deg(direction_to_mouse.dot(Vector2.DOWN)) -55
		
	#else: 
		#$Visuals.scale.x = 1
		#hand_left.rotation_degrees = rad_to_deg(direction_to_mouse.dot(Vector2.DOWN)) -55
		
	#hand_left.global_position = target_position
	
# reverse walking logic ---------------------------------------------------------------------------------------------------------
	#if direction_to_mouse.x < 0 and is_moving_right and is_running or direction_to_mouse.x > 0 and is_moving_left and is_running:
		#animation_player.play("RUN_REVERSE")
		#print("revers")
		
	
	

func _physics_process(_delta):
	velocity = movement_direction * current_speed
	
	if position.distance_to(target) > 1:
		move_and_slide()

	else:
		is_running = false
		animation_player.play("IDLE")


func emit_dust_particles():
	var particle = preload("res://scenes/player/visuals/RunDust.tscn").instantiate()
	var world = get_tree().get_first_node_in_group("world")
	particle.global_position = global_position
	particle.play()
	world.add_child(particle)
	
