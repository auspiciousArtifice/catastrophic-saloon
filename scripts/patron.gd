extends Node2D

signal despawn(n)
var id

# Called when the node enters the scene tree for the first time.
func _ready():
	id = -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		despawn.emit(id)