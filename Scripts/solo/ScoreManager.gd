extends Node

var score = 0
var high_scores = []

func _ready():
	load_high_scores()

func add_score(points):
	score += points

func reset_score():
	score = 0

func save_high_score(name):
	high_scores.append({"name": name, "score": score})
	high_scores.sort_custom(self, "sort_scores")
	if high_scores.size() > 10:
		high_scores = high_scores.slice(0, 10)
	save_high_scores()

func sort_scores(a, b):
	return b["score"] - a["score"]

func load_high_scores():
	var file = File.new()
	if file.file_exists("user://high_scores.save"):
		file.open("user://high_scores.save", File.READ)
		high_scores = parse_json(file.get_as_text())
		file.close()

func save_high_scores():
	var file = File.new()
	file.open("user://high_scores.save", File.WRITE)
	file.store_string(to_json(high_scores))
	file.close()
