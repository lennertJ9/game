extends CharacterBody2D


@onready var animation_tree = $AnimationTree as AnimationTree

@onready var animation_player1 = $AnimationPlayer
@onready var animation_player2 = $AnimationPlayer2

@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon

# walking system

var current_speed = 65
var movement_direction: Vector2
var target = Vector2.ZERO

var boolie = true


func _ready():
	pass
	

func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		$AnimationTree["parameters/conditions/is_idle"] = false
		$AnimationTree["parameters/conditions/is_walking"] = true
		$AnimationTree["parameters/WALKING/blend_position"] = movement_direction
		
		if movement_direction.x < 0:
			visuals.scale.x = -1
		else:
			visuals.scale.x = 1
		
	if event.is_action_pressed("a"):
		
		if boolie:
			animation_player2.play("ATTACK_DOWN")
			boolie = false
			
		else:
			animation_player2.play("ATTACK_DOWN_2")
			
			boolie = true
			
			
		$BoltManager.shoot(global_position.direction_to(get_global_mouse_position()), position)


func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7


func _physics_process(_delta):
	velocity = movement_direction * current_speed
	

	if position.distance_to(target) > 1:
		
		move_and_slide()
	else:
		$AnimationTree["parameters/conditions/is_idle"] = true
		$AnimationTree["parameters/conditions/is_walking"] = false
		$AnimationTree["parameters/IDLE/blend_position"] = movement_direction
		
func hide_weapon():
	$AnimationPlayer2.play('HIDE_WEAPON')
	


