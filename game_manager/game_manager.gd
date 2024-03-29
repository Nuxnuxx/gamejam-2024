const type_focus = [
	"BUILD",
	"HOUSE",
	"OBELISK",
	"DEFENSE",
	"CULT",
]

const codex_ennemies = [
	{
		"name": "skeleton",
		"difficulty": 2,
		"difficulty_min": 0,
		"speed": 100,
		"health": 75,
		"earning": 10,
		"attacking_rate": 2,
		"attacking_damages": 10,
		"score_value": 5,
		"sound": "skeleton", 
	},
	{
		"name": "skeleton_rouge",
		"difficulty": 3,
		"difficulty_min": 20,
		"speed": 45,
		"health": 100,
		"earning": 15,
		"attacking_rate": 2.5,
		"attacking_damages": 20,
		"score_value": 7,
		"sound": "skeleton",
	},
	{
		"name": "skeleton_bleu",
		"difficulty": 3,
		"difficulty_min": 30,
		"speed": 100,
		"health": 50,
		"earning": 15,
		"attacking_rate": 1.5,
		"attacking_damages": 5,
		"score_value": 7,
		"sound": "skeleton",
	},
	
	{
		"name": "ghost",
		"difficulty": 4,
		"difficulty_min": 50,
		"speed": 75,
		"health": 75,
		"earning": 15,
		"attacking_rate": 2,
		"attacking_damages": 15,
		"score_value": 7,
		"sound": "ghost",
	},
	{
		"name": "ghost_rouge",
		"difficulty": 5,
		"difficulty_min": 70,
		"speed": 75,
		"health": 100,
		"earning": 17,
		"attacking_rate": 2.5,
		"attacking_damages": 25,
		"score_value": 9,
		"sound": "ghost",
	},
	{
		"name": "ghost_bleu",
		"difficulty": 5,
		"difficulty_min": 80,
		"speed": 150,
		"health": 50,
		"earning": 18,
		"attacking_rate": 1.5,
		"attacking_damages": 10,
		"score_value": 9,
		"sound": "ghost",
	},
	
	{
		"name": "knight",
		"difficulty": 8,
		"difficulty_min": 100,
		"speed": 50,
		"health": 100,
		"earning": 30,
		"attacking_rate": 2,
		"attacking_damages": 30,
		"score_value": 15,
		"sound": "knight",
	},
	{
		"name": "knight_rouge",
		"difficulty": 10,
		"difficulty_min": 130,
		"speed": 50,
		"health": 150,
		"earning": 34,
		"attacking_rate": 2.5,
		"attacking_damages": 50,
		"score_value": 18,
		"sound": "knight",
	},
	{
		"name": "knight_bleu",
		"difficulty": 12,
		"difficulty_min": 150,
		"speed": 85,
		"health": 100,
		"earning": 38,
		"attacking_rate": 1.5,
		"attacking_damages": 30,
		"score_value": 20,
		"sound": "knight",
	},
	{
		"name": "snake",
		"difficulty": 25,
		"difficulty_min": 280,
		"speed": 95,
		"health": 200,
		"earning": 44,
		"attacking_rate": 1.7,
		"attacking_damages": 70,
		"score_value": 40,
		"sound": "snake",
	},
	{
		"name": "fire_boss",
		"difficulty": 35,
		"difficulty_min": 300,
		"speed": 30,
		"health": 700,
		"earning": 100,
		"attacking_rate": 1,
		"attacking_damages": 100,
		"score_value": 60,
		"sound": "fire_boss",
	},
	{
		"name": "ice_boss",
		"difficulty": 37,
		"difficulty_min": 300,
		"speed": 50,
		"health": 500,
		"earning": 100,
		"attacking_rate": 2,
		"attacking_damages": 80,
		"score_value": 65,
		"sound": "fire_boss",
	},
]
static var game_score = 0

static func get_codex_entity_from_name(name:String):
	for entity in codex_ennemies:
		if entity.name == name:
			return entity
	return null

static func get_ennemies_shape():
	var path = "res://Actors/Ennemy/EnnemyShape/"
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var filename_ennemies_shape = {}
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") && file_name != "EnnemyShapeSprite":
			#get_next() returns a string so this can be used to load the images into an array.
			filename_ennemies_shape[file_name.split(".")[0]] = load(path + file_name)
	dir.list_dir_end()
	return filename_ennemies_shape
