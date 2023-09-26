class_name GameOver
extends Node2D

var final_score: int

func _on_quit_button_pressed():
	get_tree().quit()

func _on_play_again_button_pressed():
	var bar_scene = load("res://bar.tscn").instantiate()
#	game_over_scene.final_score = score_counter.player_score
	get_tree().root.add_child(bar_scene)
	get_tree().get_root().remove_child(self)
