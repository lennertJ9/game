extends Node2D

@onready var hit_box_component: HitBox = $HitBoxComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	hit_box_component.damage= 10



