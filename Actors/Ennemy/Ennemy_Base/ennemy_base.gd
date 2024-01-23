extends CharacterBody2D

@export var health: float = 100
@export var focus:int = 0

@export var speed: float = 50.0

@onready var game_manager = get_node("/root/GameManager")

func set_health_to_zero()-> void:
	if health != 0:
		health = 0

func get_focus_node()-> Node:
	var focusName = game_manager.Type_Focus[focus]
	var focusedNode = get_tree().get_nodes_in_group(focusName)
	
	var closestNode = null
	var closestDistance = null
	
	for node in focusedNode:
		var distance = sqrt(pow(node.global_position.x - global_position.x, 2) + pow(node.global_position.y - global_position.y, 2))
		if closestDistance == null:
			closestNode = node
			closestDistance = distance
		elif closestDistance >= distance:
			closestNode = node
			closestDistance = distance
	return closestNode

func move_to(node: Node)-> void:
	var direction = Vector2(node.global_position.x - global_position.x, node.global_position.y - global_position.y)
	if direction.length() != 0:
		velocity = direction.normalized() * speed
		move_and_slide()
		
func _physics_process(delta):
	var focusedNode = get_focus_node()
	move_to(focusedNode)
