extends Control

@onready var abilities = $"../../Abilities"
@onready var slots = $Slots


@onready var health_component = $"../../HealthComponent"
@onready var life = $Life

func _ready():
	update_properties()
	update_health(health_component.max_health)
	
	
	for slot in $Slots.get_children():
		slot.index = slot.get_index()
	
	

func update_health(health):
	life.value = health
	


func update_properties():
	life.max_value = health_component.max_health






