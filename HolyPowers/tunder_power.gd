extends Node2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

func before_run():
	animated_sprite_2d.play("before_send")
	hitbox.global_position = global_position
	visible = true

func run():
	animated_sprite_2d.play("run")
	apply_damages()

func get_mob_to_hit():
	var overlapping_area = hitbox.get_overlapping_areas()
	var overlapping_mob = []
	
	for area in overlapping_area:
		if area.get_parent().is_in_group("ENNEMY"):
			overlapping_mob.append(area.get_parent())
	
	return overlapping_mob
	
func apply_damages():
	var mobs = get_mob_to_hit()

	for mob in mobs:
		mob.self_damage(50)
