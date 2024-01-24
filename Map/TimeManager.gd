extends Node

@onready var holy_bar = $"../CanvasLayer/HolyBar"
@onready var spawner = $"../Spawner"
@onready var wave_counter = $"../CanvasLayer/WaveCounter"
@onready var directional_light_2d = $"../DirectionalLight2D"

const WaweManager = preload("res://game_manager/wawe_manager.gd")

var current_wawe = 0
var generate_wave = false
var end_game = false

var holy_score = 10
var holy_timer = 4
var holy_income = 4
var holy_cd = false
var val = 0

func _process(delta):
	if spawner.wawe_is_running:
		directional_light_2d.energy = log(0.5 + 3*val)
		if val < 2: val += delta
		if !holy_cd:
			holy_cd = true
			holy_score += holy_income * int(holy_score < 100)
			holy_bar.value = holy_score
			await get_tree().create_timer(holy_timer).timeout
			holy_cd = false
		
	elif !generate_wave && !spawner.wawe_is_running:
		generate_wave = true
		directional_light_2d.energy = log(val + 0.5)
		if val > 0: val -= delta
		
		await get_tree().create_timer(5).timeout
		if spawner.wawe_is_running: return
		current_wawe += 1
		wave_counter.text = str(current_wawe)
		
		generate_wave = false
		var wawe = WaweManager.generate_wawe(current_wawe)
		spawner.instance_entities_from_wawe(wawe)
	else:
		generate_wave = false
