extends CharacterBody2D

@export var movement_direction: Vector2 
@export var speed: int

var spawn_point : Vector2
var max_wander_distance = 40

@onready var health_component = $HealthComponent
@onready var hurt_box = $HurtBox


func _ready():
	spawn_point = global_position
	hurt_box.hit.connect(on_hit)

func _process(delta):
	pass


func _physics_process(delta):
	velocity = movement_direction * speed
	$HurtBox.position = $visuals.offset
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
	


func on_hit(area):
	health_component.damage(area.damage)
	
	var shader = $visuals.material as ShaderMaterial
	shader.set_shader_parameter("amount", 0.65)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)
	
	


