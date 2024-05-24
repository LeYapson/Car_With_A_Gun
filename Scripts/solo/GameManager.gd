extends Node

var enemy_scene = preload("res://Scenes/solo/ennemy.tscn")
var enemies = []  # List to keep track of spawned enemies

# Variables
var round_count = 0
var ready_timer = null
var fight_timer = null

func _ready():
	pause_player()
	$Player1solo.connect("player_killed", self, "_on_player_killed")

	# Show "READY?" label initially
	$ReadyLabel.visible = true
	$FightLabel.visible = false

	# Create and start timer for "READY?" label
	ready_timer = Timer.new()
	add_child(ready_timer)
	ready_timer.wait_time = 3
	ready_timer.one_shot = true
	ready_timer.connect("timeout", self, "_on_ready_timer_timeout")
	ready_timer.start()

	# Create and start a timer for increasing enemy speed
	var speed_timer = Timer.new()
	add_child(speed_timer)
	speed_timer.wait_time = 5
	speed_timer.one_shot = false
	speed_timer.connect("timeout", self, "_on_speed_timer_timeout")
	speed_timer.start()

func _on_ready_timer_timeout():
	unpause_player()
	# Hide "READY?" label
	$ReadyLabel.visible = false

	# Show "FIGHT!" label
	$FightLabel.visible = true

	# Create and start timer for "FIGHT!" label
	fight_timer = Timer.new()
	add_child(fight_timer)
	fight_timer.wait_time = 1
	fight_timer.one_shot = true
	fight_timer.connect("timeout", self, "_on_fight_timer_timeout")
	fight_timer.start()

func _on_fight_timer_timeout():
	# Hide "FIGHT!" label
	$FightLabel.visible = false
	$SpawnTimer.start()
	$Timer.start()

func _on_SpawnTimer_timeout():
	var enemy_instance = enemy_scene.instance()
	add_child(enemy_instance)
	enemy_instance.position = $SpawnLocation.position

	# Add the enemy instance to the enemies list
	enemies.append(enemy_instance)

	var nodes = get_tree().get_nodes_in_group("spawn")
	var node = nodes[randi() % nodes.size()]
	var position = node.position
	$SpawnLocation.position = position

func _on_player_killed():
	get_tree().change_scene("res://Scenes/UI/GameOver.tscn")

func pause_player():
	$Player1solo.set_physics_process(false)

func unpause_player():
	$Player1solo.set_physics_process(true)

func _on_speed_timer_timeout():
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.increase_speed()
