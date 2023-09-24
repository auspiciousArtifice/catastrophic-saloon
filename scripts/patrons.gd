extends Node2D


var patron = preload("res://patron.tscn")
var patron_list
var id_gen
var x_locations

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	patron_list = []
	x_locations = []
	for i in 5:
		x_locations.push_back(80+150 + i*380)
	id_gen = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var p = patron.instantiate()
	var x_pos = x_locations[randi() % x_locations.size()]
	x_locations.erase(x_pos)
	p.global_position = Vector2(x_pos,850)
	add_child(p)
	p.id = id_gen
	id_gen = id_gen + 1
	p.despawn.connect(_remove_patron)
	patron_list.push_back(p)
	$Timer.wait_time = randi_range(3,5)
	if(patron_list.size() > 2):
		$Timer.stop()


func _remove_patron(n):
	for p in patron_list:
		if p.id == n:
			# print("Removed patron with id: " + str(p.id))
			patron_list.erase(p)
			x_locations.push_back(p.global_position.x)
			p.queue_free()
	if($Timer.is_stopped()):
		$Timer.start()

