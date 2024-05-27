extends Control


@onready var slots = $GridContainer.get_children()


func open():
	visible = true


func close():
	visible = false
