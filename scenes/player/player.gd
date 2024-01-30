extends CharacterBody2D



@onready var animation_player1 = $AnimationPlayer
@onready var animation_player2 = $AnimationPlayer2

@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon

# walking system
@export var speed = 40
var current_speed = 70
var movement_direction: Vector2
var target = position



func _ready():
	animation_player1.play("IDLE_DOWN")


func _input(event):
	if event.is_action_pressed("right_click"):

		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		
		if movement_direction.x > 0.6 or movement_direction.x < -0.6:
			animation_player1.play("RUN_SIDE")
			if movement_direction.x > 0:
				$Visuals.scale.x = 1
			else:
				$Visuals.scale.x = -1
				
		else:
			print("down")
			if movement_direction.y > 0:
				animation_player1.play("RUN_DOWN")
			else:
				animation_player1.play("RUN_UP")
		

	if event.is_action_pressed("a"):
		
		var animation: Animation = animation_player2.get_animation("IDLE_FRONT")
		animation.track_set_key_value(0,0,Vector2(-10,0))
		
		print(animation.track_get_key_value(0,0))
		
		
		#var tween = create_tween()
		#tween.tween_property(hand_left,"rotation_degrees", + 15, .25).set_trans(Tween.TRANS_BACK)
		#tween.tween_property(hand_left,"rotation_degrees", -10, .15)
		#var shoot_direction = (get_global_mouse_position() - $Visuals/Marker2D.global_position).normalized()
		#print(shoot_direction)
		#$BoltManager.shoot(shoot_direction,$Visuals/Marker2D.global_position)
		#$AnimationPlayer2.play("ATTACK_DOWN")
		#if shoot_direction.x > 0:
			#$Visuals.scale.x = 1
		#else:
			#$Visuals.scale.x = -1

func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7


func _physics_process(_delta):
	velocity = movement_direction * current_speed
	
	if position.distance_to(target) > 1:
		move_and_slide()

	else:
		if animation_player1.current_animation == "RUN_SIDE":
			animation_player1.play("IDLE_SIDE")
		if animation_player1.current_animation == "RUN_UP":
			animation_player1.play("IDLE_UP")
		if animation_player1.current_animation == "RUN_DOWN":
			animation_player1.play("IDLE_DOWN")
		

	
func hide_weapon():
	$AnimationPlayer2.play('HIDE_WEAPON')
	
	
