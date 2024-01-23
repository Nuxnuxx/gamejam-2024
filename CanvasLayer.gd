extends CanvasLayer

@onready var spawner = $"../Spawner"
@onready var label = $Label
@onready var time_manager = $"../TimeManager"

const game_manager = preload("res://game_manager/game_manager.gd")

func _process(_delta):
	if spawner.wawe_is_running:
		label.visible = true
		label.text = "Score: " + str(game_manager.game_score) + " Vague: " + str(time_manager.current_wawe)
	else:
		label.text = "Score: " + str(game_manager.game_score)
