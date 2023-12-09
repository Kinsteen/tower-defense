extends TileMap

var astar_grid : AStarGrid2D

func _ready():
	var grid_size = get_used_rect().size
	astar_grid = AStarGrid2D.new()
	astar_grid.region = get_used_rect()
	astar_grid.cell_size = grid_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for x in grid_size.x:
		for y in grid_size.y:
			var tile_position = Vector2(
				x + get_used_rect().position.x,
				y + get_used_rect().position.y
			)
			var tile_data = get_cell_tile_data(0, tile_position)
			
			if tile_data == null or tile_data.get_custom_data("can_walk") == false:
				astar_grid.set_point_solid(tile_position)

func get_path_to_target(source: Vector2, target: Vector2) -> Array[Vector2]:
	var map_source = local_to_map(to_local(source))
	var map_target = local_to_map(to_local(target))
	var id_path = astar_grid.get_id_path(map_source, map_target)
	
	# convert map_coordinates to global_position
	var path : Array[Vector2]= [];
	for elt in id_path:
		path.append(to_global(map_to_local(elt)))
	assert(path.size() != 0)
	return path
