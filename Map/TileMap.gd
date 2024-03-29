extends TileMap

var GridSize = 200
var Tab_tiles = {}
var can_place_building_custom_data = "can_place_building"
var tile_data
var tile
var focus
var building_is_selected = false
var hover_objects

@onready var time_manager = $"../TimeManager"
@onready var canvas_layer = $"../CanvasLayer"
@onready var batiments = $"../batiments"
@onready var tile_map = $"."
const building = preload("res://Actors/Building/Building.tscn")

func _ready():
	for x in GridSize:
		for y in GridSize:
			Tab_tiles[str(Vector2(x, y))] = {
				"Type": "Grass",
				"Position": str(Vector2(x, y))
			}
	
func _process(_delta):
	tile = local_to_map(get_global_mouse_position())
	hover_objects = to_global(map_to_local(tile))
	tile_data = tile_map.get_cell_tile_data(0, tile)
	if tile_data :
		for x in GridSize:
			for y in GridSize:
				erase_cell(2, Vector2i(x,y))
		if Tab_tiles.has(str(tile)) && building_is_selected:
			set_cell(2, tile, 1, Vector2i(0,0), 0)
				
func _input(_event):
	if Input.is_action_just_pressed("click") && building_is_selected && !focus:
		var can_place_building = tile_map.get_cell_tile_data(1, tile)
		var can_place_building_because_already_here = tile_map.get_cell_tile_data(3, tile)
		if tile_data:
			if can_place_building == null && can_place_building_because_already_here == null && time_manager.holy_score >= 10:
				time_manager.holy_score -= 10
				place_building(to_global(map_to_local(tile)))
				set_cell(3, tile, 0, Vector2(0,1), 0)
			else:
				var msg:String = "Impossible de le placer ("+ str(time_manager.holy_score) + "/10)"
				canvas_layer.pop_up(msg)
		else:
			pass

func place_building(pos: Vector2):
	var building = building.instantiate()
	building.pos.x = pos.x
	building.pos.y = pos.y
	building.is_set = true
	batiments.add_child(building)
	

func _on_button_toggled(toggled_on):
	building_is_selected = toggled_on


func _on_build_btn_mouse_entered():
	focus = true


func _on_build_btn_mouse_exited():
	focus = false
