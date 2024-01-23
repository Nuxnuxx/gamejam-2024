extends Camera2D

var is_zooming = false
var zoom_factor = 0.1
var zoom_max = 1.2

func _process(_delta):
	if Input.is_action_pressed("zoom"):
		if !is_zooming and zoom.x < zoom_max: global_position = get_global_mouse_position()
			
		is_zooming = true
		zoom.x += zoom_factor
		zoom.y += zoom_factor
		
	elif Input.is_action_pressed("unzoom"):
		zoom.x -= zoom_factor
		zoom.y -= zoom_factor
		is_zooming = false
	
