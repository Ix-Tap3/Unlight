extends CharacterBody3D

var torch_dir:float
var mouse_pos:Vector2
@onready var torch_light = $CollisionShape3D/flash_light
@export var SPEED:float = 5.0
const JUMP_VELOCITY = 4.5
@onready var animSprite:AnimatedSprite3D = $AnimatedSprite3D


func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	torch_dir = get_viewport().get_mouse_position().angle()
	torch_dir = torch_dir * torch_dir

	#torch_dir = get_viewport().get_mouse_position().angle()
	torch_light.rotation.y = torch_dir
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	## Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	var direction:Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if (direction):
		if (direction.x < 0):
			animSprite.flip_h = true
		else :
			animSprite.flip_h = false
		animSprite.play("run")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		print("dir : ")
	else:
		animSprite.play("idle")
		velocity.z = 0
		velocity.x = 0
	move_and_slide()
