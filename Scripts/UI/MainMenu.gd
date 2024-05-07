extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.play_music_menu()
	$VBoxContainer/play.grab_focus()


func _on_play_pressed():
	get_tree().change_scene("res://Scenes/multiplayer/Multiplayer.tscn")


func _on_instructions_pressed():
	get_tree().change_scene("res://Scenes/UI/instruction.tscn")


func _on_settings_pressed():
	get_tree().change_scene("res://Scenes/UI/Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()
