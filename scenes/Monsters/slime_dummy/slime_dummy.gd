extends CharacterBody2D

@export var max_speed: int = 60
@export var steer_force: float = 0.1
@export var look_ahead: int = 100
@export var num_rays = 8

var ray_directions = []
var interest = []
var danger = []

var chosen_dir = Vector2.ZERO
var acceleration = Vector2.ZERO

@onready var raycasts = $Raycasts

func _ready():
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle) # in radialen
		raycasts.get_children()[i].rotation = angle
		raycasts.get_children()[i].target_position.x = 30
	

func _physics_process(delta):
	set_interest()
	set_danger()
	choose_direction()
	
	
	var desired_velocity = chosen_dir * max_speed
	velocity = desired_velocity
	
	move_and_slide()


func set_interest():
	var path_direction = get_tree().get_first_node_in_group("player").global_position - global_position
	for i in num_rays:
		#var d = ray_directions[i].rotated(rotation).dot(path_direction)
		var d = ray_directions[i].dot(path_direction)
		interest[i] = max(-5,d)
	


func set_danger():
	for i in num_rays:
		var ray: RayCast2D = raycasts.get_children()[i]
		if ray.is_colliding():
			danger[i] = 5.0
			danger[i-1] = 2.0
			
		else:
			danger[i] = 0.0
	

func choose_direction():
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
		
	chosen_dir = chosen_dir.normalized() # 1,0


func _input(event):
	if event.is_action_pressed("debug"):
		print(danger)

func custom():
	chosen_dir = Vector2(1,0)
	for ray: RayCast2D in raycasts.get_children():
		if ray.is_colliding():
			var object_position = ray.get_collider().position
			var direction_to_object = (object_position - position).normalized()
			chosen_dir -= direction_to_object 
			chosen_dir *= 1000
			chosen_dir = chosen_dir.normalized()
			










