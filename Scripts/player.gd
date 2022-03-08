extends KinematicBody

var movement_speed = 50
var mouse_sensitivity = 0.005

func _unhandled_input(event):
	#mouse rotation
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * mouse_sensitivity)
			$Camera.rotate_x(-event.relative.y * mouse_sensitivity)
			$Camera.rotation.x = clamp($Camera.rotation.x, -1.2, 1.2)

func get_movement_input():
	# keyboard movement
	var movement_direction = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("move-forwards"):
		movement_direction -= global_transform.basis.z
	elif Input.is_action_pressed("move-backwards"):
		movement_direction += global_transform.basis.z
	
	if Input.is_action_pressed("move-left"):
		movement_direction -= global_transform.basis.x
	elif Input.is_action_pressed("move-right"):
		movement_direction += global_transform.basis.x
	
	movement_direction = movement_direction.normalized()
	
	return movement_direction

func check_keyboard_input():
	# pause menu
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	check_keyboard_input()
	var current_speed = get_movement_input() * movement_speed
	
	move_and_slide(current_speed)
