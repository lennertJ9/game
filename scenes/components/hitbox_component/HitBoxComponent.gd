extends Area2D
class_name HitBox



@export var damage_ratio: float
var damage: int

@export var knockback: bool = false
@export var knockback_strength: int
var knockback_direction: Vector2

@export var collision_dot: bool = false # dot effect via een blijvende collision
@export var dot_interval: float # om de hoeveel tijd de damage gedaan word

@export var status_effect: bool # bevat status effect
