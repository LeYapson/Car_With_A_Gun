extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
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
