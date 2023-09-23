extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var patron = preload("res://patron.tscn")
	var p = patron.instantiate()
	var rand_x = randi_range(200, 2000)
	p.global_position = Vector2(rand_x,1000)
	add_child(p)
	$Timer.wait_time = randi_range(3,5)
