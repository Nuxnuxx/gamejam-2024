extends CanvasLayer

@onready var spawner = $"../Spawner"
@onready var time_manager = $"../TimeManager"
@onready var bottom_message = %BottomMessage
@onready var score_label = $Score/ScoreLabel

const game_manager = preload("res://game_manager/game_manager.gd")

func _process(_delta):
	score_label.text = str(game_manager.game_score)

func pop_up(message, timer=3):
	bottom_message.text = message
	await get_tree().create_timer(timer).timeout
	bottom_message.text = ""
