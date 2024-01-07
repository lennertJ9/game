extends Area2D


var speed = 150
var movement_direction = Vector2.RIGHT
var angle

func _on_timer_timeout():
	queue_free()

func _ready():
	rotation_degrees = angle
	
func _physics_process(delta):
	global_position += speed * movement_direction * delta


func remove_bullet():
	queue_free()
