class_name Bar
extends Node2D

signal launch
signal ammo_changed
signal out_of_ammo

enum BarState {PREPARE, SHOOT, SERVE}

var curr_state: BarState
var shots_left: int:
	get:
		return shots_left
	set(value):
		if value <= 0:
			out_of_ammo.emit()
		shots_left = value if value >= 0 else 0
		emit_signal("ammo_changed", shots_left)

func space_pressed() -> void:
	if curr_state == BarState.PREPARE:
		print("launching shaker")
		curr_state = BarState.SHOOT
		shots_left = 6
		launch.emit()
	elif curr_state == BarState.SERVE:
		print("served")
		curr_state = BarState.PREPARE

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_state = BarState.PREPARE
	shots_left = 6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		space_pressed()
	if curr_state == BarState.SHOOT and Input.is_action_just_pressed("shoot_gun"):
		shots_left -= 1


func _on_shaker_landed():
	curr_state = BarState.SERVE
