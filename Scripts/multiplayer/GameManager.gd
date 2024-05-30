extends Node

var win_timer = null
var end_timer = null
var round_count = 0
var player1_score = 0
var player2_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	start_round()
	$HealthBarCanva/player1round/RoundWin1.visible = false
	$HealthBarCanva/player1round/RoundWin2.visible = false
	$HealthBarCanva/player1round/RoundWin3.visible = false
	$HealthBarCanva/player2round/RoundWin1.visible = false
	$HealthBarCanva/player2round/RoundWin2.visible = false
	$HealthBarCanva/player2round/RoundWin3.visible = false
	$Player1Win.visible = false
	$Player2Win.visible = false
# warning-ignore:return_value_discarded
	$HealthBarCanva/Player1.connect("player1_killed", self, "_on_player1_killed")
# warning-ignore:return_value_discarded
	$HealthBarCanva/Player2.connect("player2_killed", self, "_on_player2_killed")


# Function called when the player is killed
func _on_player1_killed():
	$HealthBarCanva/Player2.set_physics_process(false)
	$HealthBarCanva/Player1.visible = false
	# Update the label text or perform other game logic
	if player2_score == 2:
		end_game()
	else:
		player2_score += 1
		var roundWin = get_node("HealthBarCanva/player2round/RoundWin"+str(player2_score))
		roundWin.visible = true
		$Player2Win.visible = true  # Replace "YourLabel" with the name of your label node
		
		# Create and start timer for "READY?" label
		win_timer = Timer.new()
		add_child(win_timer)
		win_timer.wait_time = 3
		win_timer.one_shot = true
		win_timer.connect("timeout", self, "_on_win_timer_timeout")
		win_timer.start()


func _on_player2_killed():
	$HealthBarCanva/Player1.set_physics_process(false)
	$HealthBarCanva/Player2.visible = false
	# Update the label text or perform other game logic
	if player1_score == 2:
		end_game()
	else:
		player1_score += 1
		var roundWin = get_node("HealthBarCanva/player1round/RoundWin"+str(player1_score))
		roundWin.visible = true
		$Player1Win.visible = true  # Replace "YourLabel" with the name of your label node
		
		# Create and start timer for "READY?" label
		win_timer = Timer.new()
		add_child(win_timer)
		win_timer.wait_time = 3
		win_timer.one_shot = true
		win_timer.connect("timeout", self, "_on_win_timer_timeout")
		win_timer.start()


func _on_win_timer_timeout():
	$HealthBarCanva/Player1.set_physics_process(true)
	$HealthBarCanva/Player2.set_physics_process(true)
	$HealthBarCanva/Player1.visible = true
	$HealthBarCanva/Player2.visible = true
	$HealthBarCanva/Player1.position = Vector2(80,300)
	$HealthBarCanva/Player2.position = Vector2(944,300)
	# Hide "READY?" label
	$Player1Win.visible = false
	$Player2Win.visible = false
	$HealthBarCanva/Player1.heal()
	$HealthBarCanva/Player2.heal()
	start_round()


func start_round():
	#increment the round count
	round_count += 1


func end_game():
	if player1_score == 2:
		$HealthBarCanva/player1round/RoundWin3.visible = true
		$Player1Win.visible = true  # Replace "YourLabel" with the name of your label node
		# Create and start timer for "READY?" label
		end_timer = Timer.new()
		add_child(end_timer)
		end_timer.wait_time = 3
		end_timer.one_shot = true
		end_timer.connect("timeout", self, "_on_end_timer_timeout")
		end_timer.start()
	elif player2_score == 2:
		$HealthBarCanva/player2round/RoundWin3.visible = true
		$Player2Win.visible = true  # Replace "YourLabel" with the name of your label node
		# Create and start timer for "READY?" label
		end_timer = Timer.new()
		add_child(end_timer)
		end_timer.wait_time = 3
		end_timer.one_shot = true
		end_timer.connect("timeout", self, "_on_end_timer_timeout")
		end_timer.start()


func _on_end_timer_timeout():
	# Reset scores and round count for a new game (optional)
	player1_score = 0
	player2_score = 0
	round_count = 0
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
