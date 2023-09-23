class_name Shaker
extends RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		apply_central_impulse(Vector2(0, -1800))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#		print("clicked in object")
		var mouse_pos = get_global_mouse_position()
		var force_offset = -(get_global_position() - mouse_pos)
		var force_bullet_x = get_global_position().x - mouse_pos.x
		var force_bullet_y = -1500
		var force_bullet = Vector2(force_bullet_x * abs(force_bullet_x) / 3, force_bullet_y)
		apply_impulse(force_bullet, force_offset)
		Utils.add_score(100)
#		print("Bullet Force Vector: %s" % force_bullet)
