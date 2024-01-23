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
		"speed": 50,
		"health": 100,
		"earning": 10,
		"attacking_rate": 2,
		"attacking_damages": 10,
		"score_value": 5,
	},
	{
		"name": "archer_skeleton",
		"difficulty": 4,
		"difficulty_min": 0,
		"speed": 150,
		"health": 30,
		"earning": 10,
		"attacking_rate": 1.5,
		"attacking_damages": 20,
		"score_value": 8
	}
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
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			filename_ennemies_shape[file_name.split(".")[0]] = load(path + file_name)
	dir.list_dir_end()
	return filename_ennemies_shape
