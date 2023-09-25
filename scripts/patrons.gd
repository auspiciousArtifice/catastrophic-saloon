class_name Patrons
extends Node2D

signal serving_done
signal life_count_changed

var patron = preload("res://patron.tscn")
var patron_list
var id_gen
var x_locations
var life: int:
	get:
		return life
	set(val):
		life = val
		life_count_changed.emit()

var json = JSON.new()
var json_string = FileAccess.open("res://data/drinks.json", FileAccess.READ).get_as_text()
var error = json.parse(json_string)
var drink_data = json.data["drinks"]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	patron_list = []
	x_locations = []
	for i in 5:
		x_locations.push_back(80+150 + i*380)
	id_gen = 0
	life = 3


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
	p.drink = drink_data[randi() % drink_data.size()]
	p.despawn.connect(_remove_patron)
	p.unsatisfied.connect(_decrement_life)
	p.patron_served.connect(_exit_serving_state)
	patron_list.push_back(p)
	$Timer.wait_time = randi_range(3,5)
	if patron_list.size() > 2:
		$Timer.stop()


func _remove_patron(n):
	for p in patron_list:
		if p.id == n:
			patron_list.erase(p)
			x_locations.push_back(p.global_position.x)
			p.queue_free()
	if $Timer.is_stopped():
		$Timer.start()

func _decrement_life():
	life -= 1
	if life < 1:
		print("game over")

func _exit_serving_state():
	serving_done.emit()
	get_tree().call_group("Patron", "_on_finished_serving")
