extends KinematicBody

var current_speed = Vector3(0, 0, 0)
var jump_vector = Vector3(0, 0, 0)
var movement_speed = 50
var mouse_sensitivity = 0.005
var gravity = -100
var sprinting = false

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
	
	# sprinting
	if Input.is_action_just_pressed("sprint"):
		movement_speed = 100
	elif Input.is_action_just_released("sprint"):
		movement_speed = 50
	
	movement_direction = movement_direction.normalized()
	
	return movement_direction

func check_keyboard_input():
	# pause menu
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# crouching
	if Input.is_action_just_pressed("crouch"):
		$CollisionShape.shape.height = 2
		movement_speed = 25
	elif Input.is_action_just_released("crouch"):
		$CollisionShape.shape.height = 4
		movement_speed = 50
	
	# prone
	if Input.is_action_just_pressed("prone"):
		$CollisionShape.rotate_x(deg2rad(90))
		movement_speed = 10
	elif Input.is_action_just_released("prone"):
		$CollisionShape.rotate_x(deg2rad(-90))
		movement_speed = 50

func _physics_process(delta):
	check_keyboard_input()
	current_speed = get_movement_input() * movement_speed
	
	# jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_vector.y = 20
	
	# add gravity
	if not is_on_floor():
		jump_vector.y += gravity * delta
	
	move_and_slide(current_speed)
	move_and_slide(jump_vector, Vector3.UP)
