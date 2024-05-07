extends Node

func _ready():
	# Connect to the player's health_changed signal
	var player1 = $Player2
	player1.connect("health_changed", self, "_on_player_health_changed")
func _on_player_health_changed(new_health):
	# Update the health bar based on the player's new health
	$HealthBarP2.value = new_health
