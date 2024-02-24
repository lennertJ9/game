extends Area2D


var speed = 225
var movement_direction = Vector2.RIGHT
var angle
var damage = 1

func _on_timer_timeout():
	queue_free()

func _ready():
	rotation_degrees = angle
	if movement_direction.x < 0:
		
		$Bolt.scale.y = -1
	
func _physics_process(delta):
	global_position += speed * movement_direction * delta


func remove_bullet():
	queue_free()
