extends CharacterBody3D

var torch_dir:float
var mouse_pos:Vector2
@onready var torch_light = $flash_light
@export var SPEED:float = 5.0
const JUMP_VELOCITY = 4.5
@onready var animSprite:AnimatedSprite3D = $AnimatedSprite3D
var canrotate:bool = true;
var angle_cible:float = 0.0;
@onready var CameraCoolDown:Timer = $CameraRotationCooldown

func handle_rotation(angle:String) -> void :
	if angle == 'R':
		angle_cible += deg_to_rad(45)
	if angle == 'L':
		angle_cible += deg_to_rad(-45)
		
func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	torch_dir = get_viewport().get_mouse_position().angle() * 2

	torch_dir = get_viewport().get_mouse_position().angle()
	torch_light.rotation.y = torch_dir
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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
	if (Input.is_action_pressed("rotateleft") && canrotate):
		canrotate = false;
		CameraCoolDown.start()
		handle_rotation('L')
	if (Input.is_action_pressed("rotateright") && canrotate):
		canrotate = false;
		CameraCoolDown.start()
		handle_rotation('R')
	rotation.y = lerp_angle(rotation.y, angle_cible, 10 * delta)
	move_and_slide()


func _on_camera_rotation_cooldown_timeout() -> void:
	canrotate = true
