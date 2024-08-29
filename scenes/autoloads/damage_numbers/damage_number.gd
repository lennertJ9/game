extends Node2D

@onready var label = $Label

var damage_number: int


func _ready():
	label.text = str(damage_number)
	position += Vector2(randi_range(-5,5),randi_range(-15,-9))
	
	$AnimationPlayer.play("damage_popup")
	await $AnimationPlayer.animation_finished
	queue_free()


#func display_number(value: int, position: Vector2, is_ciritcal: bool = false) -> void:
	#var number: Label = Label.new()
	#number.global_position = position
	#number.text = str(value)
	#number.z_index = 5
	#
	#number.label_settings = LabelSettings.new()
	#var color = "#FFF"
	#if is_ciritcal:
		#color = "B22"
	#if value == 0:
		#color = "#FFF8"
	#
	#number.label_settings.font_color = color
	#
	#number.label_settings.outline_color = "#000"
	#number.label_settings.outline_size = 1
#
	#add_child(number)
