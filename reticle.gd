class_name Reticle
extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_viewport().get_mouse_position()


func _on_bar_launch():
	visible = true


func _on_out_of_ammo():
	visible = false


func _on_shaker_shaker_landed():
	visible = false
