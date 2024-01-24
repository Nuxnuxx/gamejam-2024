extends Control

@onready var time_manager = $"../../TimeManager"
@onready var score_label = $ScoreLabel
const GameManager = preload("res://game_manager/game_manager.gd")
@onready var wawe_label = $WaweLabel

func _physics_process(delta):
	if time_manager.end_game:
		visible = true
		score_label.text =str(GameManager.game_score)
		wawe_label.text = str(time_manager.current_wawe)

func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://Menu/main_menu.tscn"))
