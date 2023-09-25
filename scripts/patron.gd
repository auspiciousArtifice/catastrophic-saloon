extends Node2D

signal despawn(n)
signal unsatisfied
var id
var drink

var p_img1 = preload("res://assets/image.png")
var p_img2 = preload("res://assets/crying_patron.png")
var p_img3 = preload("res://assets/curious_patron.png")
var p_img4 = preload("res://assets/huh_patron.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	id = -1
	var tex_sel = randi_range(0,3)
	if(tex_sel == 0):
		$Area2D/Sprite2D.texture = p_img1
	elif(tex_sel == 1):
		$Area2D/Sprite2D.texture = p_img2
	elif(tex_sel == 2):
		$Area2D/Sprite2D.texture = p_img3
	else:
		$Area2D/Sprite2D.texture = p_img4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Area2D/Sprite2D/TextureProgressBar.value = 100 - $Area2D/Timer.get_time_left() * 5 


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(drink)
		despawn.emit(id)


func _on_timer_timeout():
	unsatisfied.emit()
	despawn.emit(id)
