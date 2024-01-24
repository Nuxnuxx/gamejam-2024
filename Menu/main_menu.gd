extends Control

@onready var play_btn = $PlayBtn


func _on_play_btn_pressed():
	get_tree().change_scene_to_packed(load("res://main.tscn"))
