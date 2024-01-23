extends CanvasLayer

@onready var spawner = $"../Spawner"
@onready var label = $Label

func _process(delta):
	if spawner.wawe_is_running:
		label.visible = true
	else:
		label.visible = false
