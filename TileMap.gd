extends TileMap

var GridSize = 5
var Tab_tiles = {}
var can_place_building_custom_data = "can_place_building"
var tile_data
var tile
var building_is_selected = false
var hover_objects

@onready var batiments = $"../batiments"
@onready var tile_map = $"."
const batiment = preload("res://buildings/Batiment.tscn") 

func _ready():
	for x in GridSize:
		for y in GridSize:
			Tab_tiles[str(Vector2(x, y))] = {
				"Type": "Grass",
				"Position": str(Vector2(x, y))
			}
	
func _process(delta):
	tile = local_to_map(get_global_mouse_position())
	hover_objects = to_global(map_to_local(tile))
	tile_data = tile_map.get_cell_tile_data(0, tile)
	if tile_data :
		for x in GridSize:
			for y in GridSize:
				erase_cell(1, Vector2i(x,y))
		if Tab_tiles.has(str(tile)) && building_is_selected:
			set_cell(1, tile, 1, Vector2i(0,0), 0)
				
func _input(event):
	if Input.is_action_just_pressed("click") && tile_data && building_is_selected:
		var tile_test : Vector2i = local_to_map(get_global_mouse_position())
		var can_place_building = tile_data.get_custom_data(can_place_building_custom_data)	
		if tile_data:
			if can_place_building:
				place_building(to_global(map_to_local(tile_test)))
			else:
				print("can't place")
		else:
			print("no tile data")

func place_building(pos: Vector2):
	var batiment = batiment.instantiate()
	print(pos)
	batiment.pos.x = pos.x
	batiment.pos.y = pos.y - 8
	batiment.is_set = true
	batiments.add_child(batiment)
	

func _on_button_pressed():
	building_is_selected = !building_is_selected
