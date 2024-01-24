extends Area2D

var health = 0
@export var max_health: float = 500

func _ready():
	add_to_group("BUILD", true)
	health = max_health
