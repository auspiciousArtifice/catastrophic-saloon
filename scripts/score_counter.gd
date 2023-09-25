class_name ScoreCounter
extends Node

signal accum_updated
signal player_score_updated

@export var hit_score: int = 100
@export var spin_score: int = 10
@export var perfect_land_score: int = 1000
@export var all_shots_score: int = 600
@export var patron_served_score: int = 300


var player_score: int = 0
var accum_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Should be called after shooting drink ends. Returns the new player_score
func calc_player_score() -> void:
	player_score += accum_score
	player_score_updated.emit()

# Add some value to the accumulator and return the new accumulator value
func add_to_accum(score: int) -> void:
	accum_score += score
	accum_updated.emit()


func reset_player_score() -> void:
	player_score = 0


func reset_accum_score() -> void:
	accum_score = 0
	accum_updated.emit()


func _on_shaker_hit():
	add_to_accum(hit_score)


func _on_shaker_perfect_landing():
	add_to_accum(perfect_land_score)


func _on_shaker_shaker_landed():
	calc_player_score()
	reset_accum_score()
