extends Node

var menu_music = load("res://Assets/sound/y2mate.com - Western Showdown Mario Enters  Paper Mario The Origami King OST.mp3")
var game_music = load("res://Assets/sound/y2mate.com - Super Mario 64 Slider Race Theme Song.mp3")
var solo_game_music = load ("res://Assets/sound/Shadowed Battleground.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func play_music_menu():
	$music.stream = menu_music
	$music.play()


func play_music_game():
	$music.stream = game_music
	$music.play()


func play_solo_music_game():
	$music.stream = solo_game_music
	$music.play()


func stop_music():
	$music.stop()
