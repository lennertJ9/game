extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print($"../Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = $"../Player".global_position
