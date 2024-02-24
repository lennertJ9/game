extends Node2D



@onready var resource_bar = $"../CanvasLayer/ResourceBar"


@export var max_health: int
var current_health: int

func _ready():
	current_health = max_health
	

func damage(amount):
	current_health -= amount
	
	
	if current_health <= 0:
		await get_tree().create_timer(0.1).timeout
		owner.queue_free()