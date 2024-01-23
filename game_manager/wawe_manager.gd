const game_manager = preload("res://game_manager/game_manager.gd")

static func difficulty_0_50(wawe: int)-> int:
	return int(15*exp(wawe*0.07))

static func difficulty_50_inf(wawe: int)-> int:
	return int(7 * wawe)
	
static func get_wawe_difficulty(wawe: int)-> int:
	if wawe <= 50:
		return difficulty_0_50(wawe)
	return difficulty_50_inf(wawe)
	 
	

static func get_spawnable_mob(difficulty: int)-> Array:
	var spawnable_mob = []
	
	for mob in game_manager.codex_ennemies:
		if mob["difficulty_min"] <= difficulty && mob["difficulty"] <= difficulty:
			spawnable_mob.append(mob)
	return spawnable_mob

static func update_spawnable_mob(difficulty:int, spawnable_mob: Array)-> Array:
	var spawnable_mob_final = []
	
	for mob in spawnable_mob:
		if mob["difficulty"] <= difficulty:
			spawnable_mob_final.append(mob)
	return spawnable_mob_final

static func get_mob_to_spawn(difficulty: int, pool_mob: Array)-> Dictionary:
	var updated_pool_mob = update_spawnable_mob(difficulty, pool_mob)
	var mob_to_spawn = null
	
	pool_mob.sort_custom(func(a, b): return a["difficulty"] < b["difficulty"])
	var lowest_difficulty = pool_mob[0]["difficulty"]
	
	if len(updated_pool_mob) == 0:
		var lowest_mobs = []
		for mob in pool_mob:
			if mob["difficulty"] == lowest_difficulty:
				lowest_mobs.append(mob)
		
		mob_to_spawn = lowest_mobs.pick_random()
	else:
		mob_to_spawn = updated_pool_mob.pick_random()
	return mob_to_spawn


static func generate_wawe(wawe: int)-> Dictionary:
	var difficulty = get_wawe_difficulty(wawe)
	print(difficulty)
	var pool_spawnable_mob = get_spawnable_mob(difficulty)
	var current_difficulty = difficulty
	var pool_mob_spawn = {}
	
	while current_difficulty > 0:
		var mob_to_spawn = get_mob_to_spawn(current_difficulty, pool_spawnable_mob)
		if mob_to_spawn["name"] in pool_mob_spawn:
			pool_mob_spawn[mob_to_spawn["name"]] += 1
		else:
			pool_mob_spawn[mob_to_spawn["name"]] = 1
		current_difficulty -= mob_to_spawn["difficulty"]
	
	return pool_mob_spawn
