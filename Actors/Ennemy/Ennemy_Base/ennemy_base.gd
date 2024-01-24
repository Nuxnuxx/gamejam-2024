extends CharacterBody2D 

@export var health: float = 100
@export var focus:int = 0
@export var speed: float = 50.0
@export var attacking_damages:float = 0
@export var attacking_rate:float = 0
@export var score_value: int = 0
@export var sound: String = ""

const game_manager = preload("res://game_manager/game_manager.gd")
const wawe_manager = preload("res://game_manager/wawe_manager.gd")

var attacking = false
var attack_target = null
var attack_cd = false

var sound_node = null


func self_damage(amount: float):
	health -= amount
	if health <= 0:
		game_manager.game_score += score_value
		queue_free()
		if sound_node != null:
			sound_node.get_node("Death").play()
	

func get_focus_node()-> Node:
	var focus_name = game_manager.type_focus[focus]
	var focused_node = get_tree().get_nodes_in_group(focus_name)
	
	var closest_node = null
	var closest_distance = null
	
	for node in focused_node:
		var distance = sqrt(pow(node.global_position.x - global_position.x, 2) + pow(node.global_position.y - global_position.y, 2))
		if closest_distance == null:
			closest_node = node
			closest_distance = distance
		elif closest_distance >= distance:
			closest_node = node
			closest_distance = distance
	return closest_node

func move_to(node: Node)-> void:
	var direction = Vector2(node.global_position.x - global_position.x, node.global_position.y - global_position.y).normalized()
	if direction.length() != 0 && !attacking:
		
		if direction.x < -0.1:
			get_node("Sprite").play("walk_left")
		elif direction.x > 0.1:
			get_node("Sprite").play("walk_right")
		elif direction.y < 0:
			get_node("Sprite").play("walk_up")
		else:
			get_node("Sprite").play("walk_down")
			
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		move_and_slide()
		
	elif attacking && !attack_cd:
		attack_cd = true
		if sound_node != null:
			sound_node.get_node("Death").play()
		attack_target.self_damage(attacking_damages)
		await get_tree().create_timer(attacking_rate).timeout

		attack_cd = false

func _physics_process(_delta):
	var focused_node = get_focus_node()
	if focused_node:
		move_to(focused_node)

func _on_area_2d_area_entered(area):
	if area.is_in_group("BUILD"):
		attacking = true
		attack_target = area
		
	elif area.is_in_group("PROJECTILE"):
		self_damage(area.damage)
		area.queue_free()

func _ready():
	add_to_group("ENNEMY", true)
	sound_node = get_node(sound)

func _on_area_2d_area_exited(area):
		if area.is_in_group("BUILD"):
			attacking = false
			attack_target = null
