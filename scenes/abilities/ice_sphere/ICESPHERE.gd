extends Node2D

var explosion_damage: int
var trail_damage: int
var direction: Vector2
var speed = 50
var explosion_pos: Vector2


@export var hit_box_explosion: HitBox
@export var hit_box_trail: HitBox 


func _ready():
	var mat: ParticleProcessMaterial = $GPUParticles2D2.process_material
	mat.direction = Vector3(direction.x,direction.y,0)
	
	hit_box_explosion.damage = explosion_damage
	hit_box_trail.damage = trail_damage


func _process(delta):
	if position.distance_to(explosion_pos) < 5:
		explode()


func _physics_process(delta):
	global_position += direction * speed * delta


func explode():
	speed = 0
	$AnimationPlayer.play("explode")
	await $AnimationPlayer.animation_finished
	queue_free()
