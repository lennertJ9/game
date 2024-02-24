extends Control

@onready var abilities = $"../../Abilities"
@onready var slots = $Slots



@onready var health_component = $"../../HealthComponent"
@onready var life = $Life

func _ready():
	update_properties()
	update_health(health_component.max_health)
	set_icons()

func update_health(health):
	life.value = health
	print(health)


func update_properties():
	life.max_value = health_component.max_health


func set_icons():
	var i = 0
	for ability in abilities.get_children():
		
		slots.get_child(i).set_icon(ability.png)
		i += 1
			
