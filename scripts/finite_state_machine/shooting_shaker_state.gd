class_name ShootingShakerState
extends State

signal finished_shooting

var score_accumulator: int = 0
var shots_left: int = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		finished_shooting.emit()
