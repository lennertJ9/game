extends CharacterBody2D

@export var movement_direction: Vector2 
@export var speed: int

var spawn_point : Vector2
var max_wander_distance = 40

func _ready():
	spawn_point = global_position
	

func _process(delta):
	pass


func _physics_process(delta):
	velocity = movement_direction * speed
	move_and_slide()


func jump():
	
	check()
	$AnimationPlayer.play("run")
	


func check():
	
	if movement_direction.x > 0:
		$visuals.scale.x = -1
	else:
		$visuals.scale.x = 1


#func _on_jump_timer_timeout():
	#jump()
	
