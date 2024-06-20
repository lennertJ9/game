extends CharacterBody2D
class_name Player

# tip voor later, signal manager (autoload mss )onderaan de tree die signalen verbind tussen nodes
signal stats_updated


@export var stats : statistic
@export var player_inventory : Inventory

# -------------- ANIMATIONS ---------------------------------
@onready var animation_tree = $AnimationTree as AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var attack_animations = $AttackAnimations


# -------------- VISUALS -----------------
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon

# -------------- COMPONENTS --------------------
@onready var hurt_box = $HurtBoxComponent
@onready var health_component = $HealthComponent
@onready var mana_component = $ManaComponent

# ------------- MANAGERS -------------------------
@onready var status_manager = $StatusManager
@onready var ability_manager = $AbilityManager


# -------------- ABILITIES -----------------------
@onready var projectile_manager = $ProjectileManager


# -------------- UI --------------------------------
@onready var resource_bar = $CanvasLayer/ResourceBar


# walking system
var movement_direction: Vector2
var current_direction: Vector2
var speed_status_modifier: float = 1.0
var target = Vector2.ZERO


var boolie = true


func _ready():
	hurt_box.hit.connect(on_player_hit)
	update_player_stats()
	connect_signals()
	


func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7


func _physics_process(_delta):
	velocity = movement_direction * stats.movement_speed * speed_status_modifier
	
	if position.distance_to(target) > 1:
		
		move_and_slide()
	else:
		$AnimationPlayer.play("IDLE")
		
		
		
func _input(event):
	if event.is_action_pressed("right_click"):
		mouse_click_animation()
		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		if !speed_status_modifier == 0:
			$AnimationPlayer.play("RUN") 
		
			if movement_direction.x < 0:
				visuals.scale.x = -1
			else:
				visuals.scale.x = 1
		
	if event.is_action_pressed("debug"):
		print("debug")



func update_player_stats():
	stats_updated.emit()



func on_player_hit(area):
	health_component.damage(area.damage)
	#resource_bar.update_health(health_component.current_health)
	
	if area.knockback:
		status_manager.knockback(area.movement_direction, area.knockback_strength)
	
	var shader = $Visuals/Leg.material as ShaderMaterial
	shader.set_shader_parameter("amount", .8)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)



func hide_weapon():
	attack_animations.play('HIDE_WEAPON')
	

func play_animation():
	if boolie:
		attack_animations.play("ATTACK_DOWN")
		boolie = false
		
	else:
		attack_animations.play("ATTACK_DOWN_2")
		boolie = true



func mouse_click_animation():
	var animation = preload("res://scenes/animations/mouse_click/MouseClick.tscn").instantiate()
	var world = get_tree().get_first_node_in_group("world")
	animation.global_position = get_global_mouse_position()
	get_parent().add_child(animation)


func connect_signals():
	var UI = get_tree().get_first_node_in_group("UI")
	for slot in UI.ability_bar.slots:
		slot.drag.connect(ability_manager.remove_manager)
		slot.drop.connect(ability_manager.set_ability)
	ability_manager.ability_use.connect(UI.ability_bar.start_cooldown)
	

