extends Control

@onready var abilities = $"../../Abilities"

@onready var health_component = $"../../HealthComponent"
@onready var life = $Life

func _ready():
	update_properties()
	update_health(health_component.max_health)
	
	
	

func update_health(health):
	life.value = health
	print(health)


func update_properties():
	life.max_value = health_component.max_health
