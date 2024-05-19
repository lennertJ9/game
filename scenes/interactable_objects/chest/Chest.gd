extends StaticBody2D


@onready var sprite_2d = $Sprite2D

var is_open = false


func _ready():
	$Inventory.visible = is_open
	


func _on_control_gui_input(event):
	if event.is_pressed() and event.button_index==1:
		if is_open:
			$Inventory.visible = false
			is_open = false
		else:
			$Inventory.visible = true
			is_open = true


func _on_control_mouse_entered():
	sprite_2d.frame = 1


func _on_control_mouse_exited():
	sprite_2d.frame = 0



#func _input_event(viewport, event, shape_idx):
	#if event.is_pressed() and shape_idx == 1:
		#print("press")
#
	#if event == InputEventMouseMotion:
		#print("sdsds")
