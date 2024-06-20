extends Node2D

@onready var player: Player = $Player
@onready var ui: UserInterface = $UI




func _input(event):
	if event.is_action_pressed("debug"):
		Globalsignal.signal_test.emit()



func _on_area_2d_body_entered(body):
	MapManager.change_map(MapManager.main,740,-10)
