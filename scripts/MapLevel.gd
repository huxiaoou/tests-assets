class_name MapLevel extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMgrLevel.change_tile_map_bounds(get_tile_map_bounds())

func get_tile_map_bounds() -> Array[Vector2]:
	var bounds: Array[Vector2] = []
	var x = tile_set.tile_size.x
	var y = tile_set.tile_size.y
	bounds.append(
		Vector2(
			get_used_rect().position.x * x,
			get_used_rect().position.y * y,
		)
	)
	bounds.append(
		Vector2(
			get_used_rect().end.x * x,
			get_used_rect().end.y * y,
		)
	)
	return bounds
