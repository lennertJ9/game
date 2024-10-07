extends CharacterBody2D

signal safe_velocity_calced

@export var stats: Stats

@onready var animation_player = $AnimationPlayer
@onready var sword_animation = $SwordAnimation

@onready var state_manager: StateManager = $StateManager
@onready var wander: state = $StateManager/Wander
@onready var chase: state = $StateManager/Chase
@onready var attack = $StateManager/Attack

@onready var nav_agent = $NavigationAgent2D

@onready var sword_hit_box = $Visuals/Sword/SwordHitBox

@export var hurt_box_component: Node2D
@export var health_component: Node






func check_sprite_direction(direction: Vector2):
	if direction.x < 0:
		$Visuals.scale.x = -1
	else:
		$Visuals.scale.x = 1


func _input(event):
	if event.is_action_pressed("debug"):
		print("debug")
		animation_player.play("attack")



func _on_area_2d_body_entered(body):
	chase.target = body
	state_manager.change_state(chase)



func _on_attack_range_body_entered(body):
	state_manager.change_state(attack)



func basic_attack():
	$SwordAnimation.play("attack")


func _on_attack_range_body_exited(body):
	state_manager.change_state(chase)


func hit_flash():
	var shader = $Visuals/Body.material as ShaderMaterial
	shader.set_shader_parameter("amount", .8)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)



func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
