extends RayCast2D


var current_tiledata: TileData
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var tilemap: TileMap = get_collider()
		var collision_pos = get_collision_point()
		var tile_pos = tilemap.local_to_map(collision_pos)
		var tile_data: TileData = tilemap.get_cell_tile_data(2,tile_pos)
		
		if tile_data and not tile_data.get_custom_data("modulated"):
			current_tiledata = tile_data
			current_tiledata.set_custom_data("modulated", true)
			modulate_object(current_tiledata, Color(1,1,1,0.5))
			
	else:
		if current_tiledata:
			modulate_object(current_tiledata,Color(1,1,1,1))
			current_tiledata.set_custom_data("modulated", false)
			current_tiledata = null


func modulate_object(tile: TileData, color: Color):
	
	tile.modulate = color



