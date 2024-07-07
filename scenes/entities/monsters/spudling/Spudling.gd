extends CharacterBody2D


@export var stats: statistic
@export var animation_player: AnimationPlayer

@onready var sprite = $Sprite


var danger_area_pos: Vector2



func _ready():
	pass


func check_sprite_direction(direction: Vector2):
	if direction.x < 0:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1






