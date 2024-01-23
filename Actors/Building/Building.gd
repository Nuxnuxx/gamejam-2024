extends Area2D

var mob_in_range = []
var reloading = false

@onready var projectile = $Projectile
@export var delay_to_shoot: float = 1
@onready var all_projectiles = $AllProjectiles
@onready var start_point_projectile = $StartPointProjectile
var is_set = false
var pos : Vector2 

func _ready():
	add_to_group("BUILD", true)

func _process(delta):
	if !reloading:
		reloading = true
		attack_shoot()
		await get_tree().create_timer(delay_to_shoot).timeout
		reloading = false
	if is_set:
		global_position = pos

	
func attack_shoot():
	var not_freed_mob_in_range = []
	for mob in mob_in_range:
		if mob != null:
			not_freed_mob_in_range.append(mob)
	mob_in_range = not_freed_mob_in_range
	
	if len(mob_in_range):
		var mob_to_shoot = mob_in_range[0]
		var projectile_to_send = projectile.duplicate()
		
		projectile_to_send.visible = true
		projectile_to_send.global_position = start_point_projectile.global_position
		all_projectiles.add_child(projectile_to_send)
		projectile_to_send.go_to_mob_to_shoot(mob_to_shoot)

func _on_projectile_range_area_entered(area):
	if area.get_parent().is_in_group("ENNEMY"):
		mob_in_range.append(area)


func _on_projectile_range_area_exited(area):
	if area.is_in_group("ENNEMY"):
		pass
