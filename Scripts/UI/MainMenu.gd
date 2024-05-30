extends Control

onready var leaderboard_label = $LeaderboardLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	update_leaderboard()
	MusicController.play_music_menu()
	$VBoxContainer/solo.grab_focus()


func _on_multi_pressed():
	get_tree().change_scene("res://Scenes/multiplayer/Multiplayer.tscn")


func _on_instructions_pressed():
	get_tree().change_scene("res://Scenes/UI/instruction.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_solo_pressed():
	get_tree().change_scene("res://Scenes/solo/solo.tscn")


func update_leaderboard():
	var leaderboard_text = "High Scores:\n"
	var high_scores = get_node("/root/ScoreManager").high_scores
	for i in range(high_scores.size()):
		var entry = high_scores[i]
		leaderboard_text += str(i + 1) + ". " + entry["name"] + " - " + str(entry["score"]) + "\n"
	leaderboard_label.text = leaderboard_text
