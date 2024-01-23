extends Node

@onready var spawner = $"../Spawner"
const WaweManager = preload("res://game_manager/wawe_manager.gd")

var current_wawe = 0

func _process(_delta):
	if spawner.wawe_is_running:
		pass
	else:
		#await get_tree().create_timer(30).timeout
		current_wawe += 1
		var wawe = WaweManager.generate_wawe(current_wawe)
		spawner.instance_entities_from_wawe(wawe)
		
