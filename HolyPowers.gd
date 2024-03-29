extends Node

var use_tunder = false
var tunder_running = false
var tunder_cost = 15

@onready var time_manager = $"../TimeManager"
@onready var tunder_power_btn = $"../CanvasLayer/TunderPower"
@onready var canvas_layer = $"../CanvasLayer"
@onready var tunder_power = $TunderPower

func _on_tunder_power_toggled(toggled_on):
	if toggled_on && time_manager.holy_score >= tunder_cost:
		use_tunder = true
	
	elif toggled_on:
		canvas_layer.pop_up("Points de foi insufisants (" + str(time_manager.holy_score) + "/" + str(tunder_cost) + ")", 1.5)
		use_tunder = false
		tunder_power.visible = false
		tunder_power_btn.set_pressed_no_signal(false)
	
	else:
		use_tunder = false
		tunder_power_btn.set_pressed_no_signal(false)
		tunder_power.visible = false
		
func _process(_delta):
	if use_tunder and !tunder_running:
		canvas_layer.pop_up("before")
		tunder_power.before_run()
		tunder_power.global_position = get_viewport().get_mouse_position()
		
		if Input.is_action_pressed("click") and !tunder_running:
			tunder_running = true
			time_manager.holy_score -= tunder_cost
			tunder_power.run()
	
	if tunder_running && !tunder_power.animated_sprite_2d.is_playing():
		tunder_running = false
		tunder_power.visible = false
		use_tunder = false
		tunder_power_btn.set_pressed_no_signal(false)
		
		
	
