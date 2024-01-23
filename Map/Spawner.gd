extends Node

const wawe_manager = preload("res://game_manager/wawe_manager.gd")

const ennemy_base = preload("res://Actors/Ennemy/Ennemy_Base/Ennemy_Base.tscn")

var wawe_test = { "archer_skeleton": 4, "skeleton": 7 }


	
func instance_entities_from_wawe(wawe: Dictionary)-> void:
	var spawn_points = self.get_children()
	var index = 0
	
	for entity_type in wawe:
		for index_instance in wawe[entity_type]:
			await get_tree().create_timer(0.03).timeout
			var instance = ennemy_base.instantiate()
			instance.global_position = spawn_points[index].global_position
			
			spawn_points[index].add_child(instance)
			index = (index + 1) % len(spawn_points)

func _ready():
	instance_entities_from_wawe(wawe_test)
