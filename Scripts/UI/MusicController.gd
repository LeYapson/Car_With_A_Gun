extends Node

var menu_music = load("res://Assets/sound/y2mate.com - Western Showdown Mario Enters  Paper Mario The Origami King OST.mp3")
var game_music = load("res://Assets/sound/y2mate.com - Super Mario 64 Slider Race Theme Song.mp3")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func play_music_menu():
	$music.stream = menu_music
	$music.play()

func play_music_game():
	$music.stream = game_music
	$music.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
