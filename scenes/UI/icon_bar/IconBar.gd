extends NinePatchRect

signal inventory_button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_inventory_button_button_up():
	inventory_button.emit()
