extends Node

# Variables
var ready_timer = null
var fight_timer = null


func _ready():
	pausePlayer()

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
	unpausePlayer()
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


func pausePlayer():
	$Player1solo.set_physics_process(false)
	$ennemy.set_physics_process(false)
	$ennemy2.set_physics_process(false)
	$ennemy3.set_physics_process(false)
	$ennemy4.set_physics_process(false)
	$ennemy5.set_physics_process(false)
	$ennemy6.set_physics_process(false)
	$ennemy7.set_physics_process(false)
	$ennemy8.set_physics_process(false)
	$ennemy9.set_physics_process(false)
	$ennemy10.set_physics_process(false)
	$ennemy11.set_physics_process(false)
	$ennemy12.set_physics_process(false)
	$ennemy13.set_physics_process(false)
	$ennemy14.set_physics_process(false)
	$ennemy15.set_physics_process(false)
	
func unpausePlayer():
	$Player1solo.set_physics_process(true)
	$ennemy.set_physics_process(true)
	$ennemy2.set_physics_process(true)
	$ennemy3.set_physics_process(true)
	$ennemy4.set_physics_process(true)
	$ennemy5.set_physics_process(true)
	$ennemy6.set_physics_process(true)
	$ennemy7.set_physics_process(true)
	$ennemy8.set_physics_process(true)
	$ennemy9.set_physics_process(true)
	$ennemy10.set_physics_process(true)
	$ennemy11.set_physics_process(true)
	$ennemy12.set_physics_process(true)
	$ennemy13.set_physics_process(true)
	$ennemy14.set_physics_process(true)
	$ennemy15.set_physics_process(true)
