extends Node

func reset_score() -> void:
	Game.player_score = 0
	
func upload_score() -> bool:
	return true
	# Implement score upload to loot locker

func add_score(score: int) -> void:
	Game.player_score += score
