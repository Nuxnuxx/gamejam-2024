extends Node

@onready var spawner = $"../Spawner"
const WaweManager = preload("res://game_manager/wawe_manager.gd")

var current_wawe = 0
var generate_wave = false

func _process(delta):
	if spawner.wawe_is_running:
		print('wave running')
	elif !generate_wave && !spawner.wawe_is_running:
		generate_wave = true
		await get_tree().create_timer(5).timeout
		
		current_wawe += 1
		generate_wave = false
		var wawe = WaweManager.generate_wawe(current_wawe)
		spawner.instance_entities_from_wawe(wawe)

