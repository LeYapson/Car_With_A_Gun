extends Node

func _ready():
	# Connect to the player's health_changed signal
	var player1 = $Player1
	var player2 = $Player2
	
	#connect the player signal
	player1.connect("health_changed", self, "_on_player1_health_changed")
	player2.connect("health_changed", self, "_on_player2_health_changed")


func _on_player1_health_changed(new_health):
	# Update the health bar based on the player's new health
	$HealthBarP1.value = new_health

func _on_player2_health_changed(new_health):
	# Update the health bar based on the player's new health
	$HealthBarP2.value = new_health
