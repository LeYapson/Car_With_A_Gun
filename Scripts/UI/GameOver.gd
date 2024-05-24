extends Control

onready var submit_button = $HBoxContainer2/SubmitScore
onready var retry_button = $HBoxContainer2/Retry
onready var score_label = $ScoreDisplay  # Assuming you have a Label node named ScoreLabel

var current_letter_index = 0
var letters = ["A", "A", "A"]

func _ready():
	# Update the score label
	update_score_display()

func _process(delta):
	# Handle input using Input.is_action_pressed
	if Input.is_action_pressed("up1"):
		if current_letter_index < 2:
			increment_letter(1)
		else:
			submit_button.grab_focus()
	elif Input.is_action_pressed("down1"):
		if current_letter_index < 2:
			increment_letter(-1)
		else:
			retry_button.grab_focus()
	elif Input.is_action_pressed("right1"):
		if current_letter_index < 3:
			move_to_next_letter(1)
	elif Input.is_action_pressed("left1"):
		if current_letter_index < 3 and current_letter_index > 0:
			move_to_next_letter(-1)
	elif Input.is_action_pressed("fire1"):
		if current_letter_index == 3:
			submit_score()
		else:
			move_to_next_letter(1)
	elif Input.is_action_pressed("fire1"):
		retry()

func increment_letter(delta):
	var current_char = letters[current_letter_index]
	var new_char = char_increment(current_char, delta)
	letters[current_letter_index] = new_char
	update_score_display()

# Define a lookup table for characters
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

func char_increment(character, delta):
	var index = alphabet.find(character)
	if index == -1:
		return character  # Character not found in the alphabet
	var new_index = (index + delta) % alphabet.length()
	return alphabet[new_index]

func move_to_next_letter(delta):
	current_letter_index += delta
	if current_letter_index < 0:
		current_letter_index = 0
	elif current_letter_index > 2:
		current_letter_index = 2
	update_score_display()

func submit_score():
	var name = "".join(letters)
	ScoreManager.save_high_score(name)
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")  # Change to your main menu scene path

func retry():
	get_tree().change_scene("res://Scenes/solo/solo.tscn")  # Change to your game scene path

func _on_submit_pressed():
	submit_score()

func update_score_display():
	score_label.text = "Score: " + str(ScoreManager.score)
