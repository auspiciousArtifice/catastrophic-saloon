class_name Shaker
extends RigidBody2D

signal shaker_hit
signal shaker_landed
signal perfect_landing
signal shaker_spin

var launched: bool = false
var airborne: bool = false
var rotated_degrees: float = 0.0
var prev_degrees: float
var launch_timer: Timer = Timer.new()

@export var bottom_ray_cast: RayCast2D

## Sets the airborne flag to true for state changing purposes
func set_airborne() -> void:
	airborne = true

## Checks if the bottom of the shaker is touching the floor using the child
## RayCast2D instance and emits the perfect_landing signal if so
func check_landing() -> void:
	if not bottom_ray_cast.is_colliding():
		return
	print("%s" % bottom_ray_cast.get_collider().name)
	if bottom_ray_cast.get_collider().name == "FloorNode":
		perfect_landing.emit()
		print("perfect landing!")

func _ready():
	prev_degrees = rotation_degrees
	launch_timer.wait_time = 0.05
	launch_timer.one_shot = true
	launch_timer.connect("timeout", set_airborne)
	add_child(launch_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		launched = true
		apply_central_impulse(Vector2(0, -1800))
		launch_timer.start()
		print("launched")
	
	if launched and airborne:
		check_rotation()
	
	# After the shaker is launched and the timer for getting the shaker airborne
	# has stopped, detect if the shaker has stopped moving, or in other words,
	# when it has landed. This will signal that the shooting period has ended.
	if launched and airborne and abs(linear_velocity.length()) <= 0.01:
		launched = false
		airborne = false
		check_landing()
		shaker_landed.emit()
		print("landed")

## Observes rotation of shaker and emits signal when shaker spins 360 degrees
func check_rotation() -> void:
	var curr_degrees = rotation_degrees
	rotated_degrees += abs(abs(prev_degrees) - abs(curr_degrees))
	if rotated_degrees >= 360:
		print("spin!")
		rotated_degrees -= 360
		shaker_spin.emit()
	prev_degrees = curr_degrees

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#		print("clicked in object")
		var mouse_pos = get_global_mouse_position()
		var force_offset = -(get_global_position() - mouse_pos)
		var force_bullet_x = get_global_position().x - mouse_pos.x
		var force_bullet_y = -1500
		var force_bullet = Vector2(force_bullet_x * abs(force_bullet_x) / 3, force_bullet_y)
		apply_impulse(force_bullet, force_offset)
		shaker_hit.emit()
#		print("Bullet Force Vector: %s" % force_bullet)
