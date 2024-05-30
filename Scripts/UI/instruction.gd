extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/return.grab_focus()


func _on_return_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
