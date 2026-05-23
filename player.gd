extends CharacterBody3D

var torch_dir:float
var mouse_pos:Vector2
@onready var torch_light = $flash_light
@onready var camera = $Camera3D 
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
	var mouse_pos = get_viewport().get_mouse_position()
	# Cast a ray from the camera through the mouse position
	var ray_origin = camera.project_ray_origin(mouse_pos)	
	var ray_dir = camera.project_ray_normal(mouse_pos)
	
	# Find where the ray hits a plane at the character's height (Y level)
	var plane = Plane(Vector3.UP, global_position.y)
	var intersection = plane.intersects_ray(ray_origin, ray_dir)
	
	if intersection:
		var look_target = intersection
		torch_light.look_at(look_target, Vector3.UP)
	
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
