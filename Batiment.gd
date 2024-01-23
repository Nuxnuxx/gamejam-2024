extends Sprite2D

@onready var tile_map = $"../TileMap"
var is_set = false
var pos : Vector2 

func _process(delta):
	if is_set:
		global_position = pos
