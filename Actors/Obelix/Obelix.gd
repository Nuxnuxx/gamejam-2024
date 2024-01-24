extends Area2D

var health = 0
@export var max_health: float = 500
@onready var time_manager = $"../TimeManager"

func self_damage(amount):
	health -= amount
	if health <= 0:
		time_manager.generate_wave = false
		$AudioStreamPlayer.play()
		time_manager.end_game = true
		queue_free()


func _ready():
	add_to_group("BUILD", true)
	health = max_health
