extends Node2D

# Variables
var ready_timer = null
var fight_timer = null


# Called when the node enters the scene tree for the first time.
func _ready():
	$GameManager/HealthBarCanva/Player1.set_physics_process(false)
	$GameManager/HealthBarCanva/Player2.set_physics_process(false)
	MusicController.play_music_game()
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


func _on_ready_timer_timeout():
	$GameManager/HealthBarCanva/Player1.set_physics_process(true)
	$GameManager/HealthBarCanva/Player2.set_physics_process(true)
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
