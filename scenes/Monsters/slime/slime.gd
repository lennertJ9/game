extends CharacterBody2D


@export var stats : statistic

@export var movement_direction: Vector2 
@export var current_direction: Vector2


var spawn_point : Vector2
var max_wander_distance = 40
var max_chase_distance = 250
var jump_cooldown: int = 0
var speed: int 
var speed_status_modifier: float = 1.0

@onready var state_manager = $StateManager as StateManager
@onready var attack_state = $StateManager/AttackState
@onready var wander_state = $StateManager/WanderState


@onready var health_component = $HealthComponent
@onready var hurt_box = $HurtBox
@onready var detection_range = $DetectionRange

@onready var navigation_agent_2d = $NavigationAgent2D


func _ready():
	spawn_point = global_position
	hurt_box.hit.connect(on_hit)
	detection_range.body_entered.connect(_on_detection)
	
	
	jump()
	


func _process(delta):
	pass


func _physics_process(delta):
	velocity = current_direction * speed * speed_status_modifier
	$HurtBox.position = $visuals.offset
	move_and_slide()



func jump():
	
	check()
	current_direction = movement_direction
	
	$AnimationPlayer.play("run")
	
	


func check():
	
	if movement_direction.x > 0:
		$visuals.scale.x = -1
		if detection_range:
			detection_range.scale.x = -1
	else:
		$visuals.scale.x = 1
		if detection_range:
			detection_range.scale.x = 1


func on_hit(area):
	health_component.damage(area.damage)
	
	var shader = $visuals.material as ShaderMaterial
	shader.set_shader_parameter("amount", 0.65)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)


func _on_animation_player_animation_finished(anim_name):
	await get_tree().create_timer(jump_cooldown).timeout
	jump()
	

func _on_detection(body: Node2D):
	state_manager.change_state(attack_state)
	jump_cooldown = 0
	jump()
	stats.movement_speed = 70

func update_speed():
	speed = stats.movement_speed

func specific_wander_logic():
	jump_cooldown = randf_range(0.5,3)



