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
	var new_score = {"name": name, "score": score}
	var inserted = false
	for i in range(high_scores.size()):
		if high_scores[i]["score"] < new_score["score"]:
			high_scores.insert(i, new_score)
			inserted = true
			break
	if not inserted:
		high_scores.append(new_score)
	
	if high_scores.size() > 4:
		high_scores = high_scores.slice(0, 4)
	
	save_high_scores()


func load_high_scores():
	var file = File.new()
	if file.file_exists("res://high_scores.save"):
		file.open("res://high_scores.save", File.READ)
		high_scores = parse_json(file.get_as_text())
		file.close()


func save_high_scores():
	var file = File.new()
	file.open("res://high_scores.save", File.WRITE)
	file.store_string(to_json(high_scores))
	file.close()
