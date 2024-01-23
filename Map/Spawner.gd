extends Node

const wawe_manager = preload("res://game_manager/wawe_manager.gd")
const game_manager = preload("res://game_manager/game_manager.gd")

const ennemy_base = preload("res://Actors/Ennemy/Ennemy_Base/Ennemy_Base.tscn")
var ennemies_shape = game_manager.get_ennemies_shape()

var wawe_is_running = false

var wawe_test = { "archer_skeleton": 4, "skeleton": 7 }
	
func instance_entities_from_wawe(wawe: Dictionary)-> void:
	var spawn_points = self.get_children()
	var index = 0
	
	for entity_type in wawe:
		var codex_info = game_manager.get_codex_entity_from_name(entity_type)
		var ennemy_shape = ennemies_shape[entity_type].instantiate()
		for index_instance in wawe[entity_type]:
			await get_tree().create_timer(0.03).timeout
			var instance = ennemy_base.instantiate()
			# Passation des informations du codex a l'instance creer
			instance.health = codex_info.health
			instance.speed = codex_info.speed
			instance.global_position = spawn_points[index].global_position
			
			# Dans ennemy shape le premier element doit etre le sprite et le deuxieme, la collideBox
			instance.add_child(ennemy_shape.get_child(0).duplicate(),false,1)
			# Dans ennemy base le premier element doit etre l'area2d
			instance.get_child(0).add_child(ennemy_shape.get_child(1).duplicate(),false,1)

			spawn_points[index].add_child(instance)
			index = (index + 1) % len(spawn_points)

func _process(delta):
	var spawn_points = self.get_children()
	for spawn_point in spawn_points:
		if len(spawn_point.get_children()):
			wawe_is_running = true

func _ready():
	instance_entities_from_wawe(wawe_test)
