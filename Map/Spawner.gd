extends Node

const wawe_manager = preload("res://game_manager/wawe_manager.gd")
const game_manager = preload("res://game_manager/game_manager.gd")

const ennemy_base = preload("res://Actors/Ennemy/Ennemy_Base/Ennemy_Base.tscn")
var ennemies_shape = game_manager.get_ennemies_shape()

var wawe_is_running = false
	
func instance_entities_from_wawe(wawe: Dictionary)-> void:
	var spawn_points = self.get_children()
	var index = 0
	
	for entity_type in wawe:
		var codex_info = game_manager.get_codex_entity_from_name(entity_type)
		var ennemy_shape = ennemies_shape[entity_type].instantiate()
		ennemy_shape.add_to_group("ENNEMY", true)
		for index_instance in wawe[entity_type]:
			await get_tree().create_timer(0.03).timeout
			var instance = ennemy_base.instantiate()
			# Passation des informations du codex a l'instance creer
			instance.health = codex_info.health
			instance.speed = codex_info.speed
			instance.global_position = spawn_points[index].global_position
			instance.attacking_damages = codex_info.attacking_damages
			instance.attacking_rate = codex_info.attacking_rate
			instance.score_value = codex_info.score_value
			instance.sound = codex_info.sound
			
			# Dans ennemy shape le premier element doit etre le sprite et le deuxieme, la collideBox
			instance.add_child(ennemy_shape.get_child(1).duplicate(),false,1)
			# Dans ennemy base le premier element doit etre l'area2d
			instance.get_child(0).add_child(ennemy_shape.get_child(0).duplicate(),false,1)

			spawn_points[index].add_child(instance)
			index = (index + 1) % len(spawn_points)

func _process(_delta):
	var child_found = false
	var spawn_points = get_children()
	
	for spawn_point in spawn_points:
		if len(spawn_point.get_children()) > 0:
			child_found = true
	
	wawe_is_running = child_found
