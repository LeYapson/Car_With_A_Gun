extends Control

onready var score_label = $ScoreDisplay
onready var sprites = [$HBoxContainer/Sprite0, $HBoxContainer/Sprite1, $HBoxContainer/Sprite2]

var current_letter_index = 0
var letters = ["A", "A", "A"]
# Define a lookup table for characters
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.stop_music()
	# Update the score label
	update_score_display()
	update_sprites_visibility()


func _process(delta):
	# Handle input using Input.is_action_pressed
	if Input.is_action_just_pressed("up1"):
		increment_letter(1)
	elif Input.is_action_just_pressed("down1"):
		increment_letter(-1)
	elif Input.is_action_just_pressed("right1"):
		move_to_next_letter(1)
	elif Input.is_action_just_pressed("left1"):
		move_to_next_letter(-1)
	elif Input.is_action_just_pressed("fire1"):
		if current_letter_index == 2:
			submit_score()
		else:
			move_to_next_letter(1)
	elif Input.is_action_just_pressed("rafale1"):
		retry()


func increment_letter(delta):
	var current_char = letters[current_letter_index]
	var new_char = char_increment(current_char, delta)
	letters[current_letter_index] = new_char
	update_score_display()


func char_increment(character, delta):
	var index = alphabet.find(character)
	if index == -1:
		return character  # Character not found in the alphabet
	var new_index = (index + delta) % alphabet.length()
	if new_index < 0:
		new_index = alphabet.length() - 1
	return alphabet[new_index]


func move_to_next_letter(delta):
	current_letter_index += delta
	if current_letter_index < 0:
		current_letter_index = 0
	elif current_letter_index > 2:
		current_letter_index = 3
	update_sprites_visibility()


func submit_score():
	var name = "".join(letters)
	ScoreManager.save_high_score(name)
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")  # Change to your main menu scene path


func retry():
	get_tree().change_scene("res://Scenes/solo/solo.tscn")  # Change to your game scene path


func _on_submit_pressed():
	submit_score()


func update_score_display():
	score_label.text = "Score: " + str(ScoreManager.score) + "\n" + "".join(letters)


func update_sprites_visibility():
	for i in range(sprites.size()):
		sprites[i].visible = (i == current_letter_index)
