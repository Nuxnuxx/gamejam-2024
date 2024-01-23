extends CanvasLayer

@onready var spawner = $"../Spawner"
@onready var label = $Label
@onready var time_manager = $"../TimeManager"

func _process(_delta):
	if spawner.wawe_is_running:
		label.visible = true
		label.text = str(time_manager.current_wawe)
	else:
		label.visible = false
