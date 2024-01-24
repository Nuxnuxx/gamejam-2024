extends Control

@onready var time_manager = $"../../TimeManager"
@onready var score_label = $ScoreLabel
const GameManager = preload("res://game_manager/game_manager.gd")

func _physics_process(delta):
	if time_manager.end_game:
		visible = true
		score_label.text =str(GameManager.game_score)
