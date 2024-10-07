extends TileMapLayer


@onready var trees: TileMapLayer = $"../Trees"



# gaat over elke tile die zich bevind in de trees, als een tile een collision bevat word _tile_data_runtime_update() uitgevoerd 
# om de navigation te verwijderen
func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in trees.get_used_cells_by_id(0):
		if trees.get_cell_tile_data(coords).get_collision_polygons_count(0):
			return true
	return false
	


func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_navigation_polygon(0,null)
	
