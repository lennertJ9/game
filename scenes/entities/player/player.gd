extends CharacterBody2D
class_name Player

# tip voor later, signal manager (autoload mss )onderaan de tree die signalen verbind tussen nodes


@export var stats : Stats
@export var player_inventory : Inventory

# -------------- ANIMATIONS ---------------------------------
@onready var animation_player: AnimationPlayer = $"ANIMATIONS/AnimationPlayer"
@onready var attack_animations: AnimationPlayer = $"ANIMATIONS/AttackAnimations"


# -------------- VISUALS -----------------
@onready var visuals: Node2D = $Visuals
@onready var run_dust: Sprite2D = $Visuals/RunDust
@onready var hand_left: Sprite2D = $Visuals/HandLeft
@onready var weapon: Sprite2D = $Visuals/Weapon


# -------------- COMPONENTS --------------------
@export var hurt_box_component: Node2D
@export var health_component: HealthComponent
@export var status_component: Node


# ------------- MANAGERS -------------------------
@onready var ability_manager: Node = $MANAGERS/AbilityManager


# walking system
var movement_direction: Vector2
var current_direction: Vector2
var speed_status_modifier: float = 1.0
var target: Vector2 = Vector2.ZERO
var boolie: bool = true





func _process(delta: float) -> void:
	var direction_to_mouse: Vector2 = (get_global_mouse_position() - global_position).normalized()
	var target_position: Vector2 = global_position + Vector2(0,-4) + direction_to_mouse * 7
	


func _physics_process(_delta: float) -> void:
	velocity = movement_direction * stats.movement_speed * speed_status_modifier
	
	if position.distance_to(target) > 1:
		move_and_slide()
	else:
		animation_player.play("IDLE")
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		mouse_click_animation()
		target = get_global_mouse_position()
		movement_direction = position.direction_to(target)
		if !speed_status_modifier == 0:
			animation_player.play("RUN") 
		
			if movement_direction.x < 0:
				visuals.scale.x = -1
			else:
				visuals.scale.x = 1




func hit_flash() -> void:
	var shader: ShaderMaterial = $Visuals/Leg.material as ShaderMaterial
	shader.set_shader_parameter("amount", .8)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)




func mouse_click_animation() -> void:
	var animation: Node = preload("res://scenes/animations/mouse_click/MouseClick.tscn").instantiate()
	var world: Node = get_tree().get_first_node_in_group("world")
	animation.global_position = get_global_mouse_position() + Vector2(0,0)
	get_parent().add_child(animation)











