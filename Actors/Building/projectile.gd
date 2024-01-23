extends Area2D

var target = null
 
@export var speed = 10.0
@export var damage = 50

func _ready():
	add_to_group("PROJECTILE", true)

func _physics_process(delta):
	if target == null && visible:
		queue_free()
		return
	elif target == null:
		return
	var direction = Vector2(target.global_position.x - global_position.x, target.global_position.y - global_position.y).normalized()
	if direction.length() != 0:
		global_position.x += direction.x * speed
		global_position.y += direction.y * speed

func go_to_mob_to_shoot(mob: Area2D):
	target = mob
