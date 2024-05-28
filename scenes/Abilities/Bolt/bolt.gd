extends Area2D

@export var resource : Resource

var movement_direction: Vector2
var damage: int
var speed: int

func _on_timer_timeout():
	queue_free()

func _ready():
	rotation_degrees = rad_to_deg(movement_direction.angle())


func _physics_process(delta):
	global_position += speed * movement_direction * delta


func remove_bullet():
	queue_free()
