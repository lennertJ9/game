extends CharacterBody2D


@export var target: Vector2 = Vector2(150,0)
var speed = 50
var acceleration = 7

@onready var navigation_agent_2d = $Navigation/NavigationAgent2D

func _ready():
	$Navigation/Timer.timeout.connect(on_timeout)
	

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	direction = navigation_agent_2d.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = direction * speed
	
	move_and_slide()


func on_timeout():
	navigation_agent_2d.target_position = target
