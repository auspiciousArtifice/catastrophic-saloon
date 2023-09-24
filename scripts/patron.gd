extends Node2D

signal despawn(n)
var id

var p_img1 = preload("res://assets/image.png")
var p_img2 = preload("res://assets/crying_patron.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	id = -1
	var tex_sel = randi_range(0,1)
	if(tex_sel == 0):
		$Area2D/Sprite2D.texture = p_img1
	else:
		$Area2D/Sprite2D.texture = p_img2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		despawn.emit(id)
