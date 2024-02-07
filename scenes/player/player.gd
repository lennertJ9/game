extends CharacterBody2D



@onready var animation_player1 = $AnimationPlayer
@onready var animation_player2 = $AnimationPlayer2

@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon

# walking system
@export var speed = 40
var current_speed = 65
var movement_direction: Vector2
var target = Vector2.ZERO

var boolie = true

func _ready():
	animation_player1.play("IDLE_DOWN")


func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		update_running_animation(global_position.direction_to(get_global_mouse_position()))
		
	if event.is_action_pressed("a"):
		if boolie:
			animation_player2.play("ATTACK_DOWN")
			boolie = false
			print("1")
		else:
			animation_player2.play("ATTACK_DOWN_2")
			
			boolie = true
			print('2')
			
		$BoltManager.shoot(global_position.direction_to(get_global_mouse_position()), position)
		update_running_animation(global_position.direction_to(get_global_mouse_position()))
		

func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7


func _physics_process(_delta):
	velocity = movement_direction * current_speed
	
	if position.distance_to(target) > 1:
		print('ffff')
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
	

func update_running_animation(direction):
	
	
	print(movement_direction)
	if direction.x > 0.6 or direction.x < -0.6:
		animation_player1.play("RUN_SIDE")
		if direction.x > 0:
			$Visuals.scale.x = 1
		else:
			$Visuals.scale.x = -1
			
	else:
		
		if direction.y > 0:
			animation_player1.play("RUN_DOWN")
			if direction.x > 0:
				$Visuals.scale.x = 1
			else:
				$Visuals.scale.x = -1
		else:
			animation_player1.play("RUN_UP")
			if direction.x > 0:
				$Visuals.scale.x = 1
			else:
				$Visuals.scale.x = -1
