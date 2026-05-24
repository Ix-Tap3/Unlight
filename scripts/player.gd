extends CharacterBody3D

var torch_blink:bool = false
@onready var torch_count:int = 3
var torch_dir:float
var mouse_pos:Vector2
@onready var torch_light = $flash_light
@onready var camera = $SpringArm3D/Camera3D 
@export var SPEED:float = 5.0
const JUMP_VELOCITY = 4.5
@onready var animSprite:AnimatedSprite3D = $AnimatedSprite3D
var canrotate:bool = true;
var angle_cible:float = 0.0;
@onready var CameraCoolDown:Timer = $CameraRotationCooldown
@onready var blinkTimer:Timer = $TorchBlinking
@onready var ventouse_preload = preload("res://scenes/Player/atk/ventouse_atck.tscn")

func handle_rotation(angle:String) -> void :
	if angle == 'R':
		angle_cible += deg_to_rad(45)
	if angle == 'L':
		angle_cible += deg_to_rad(-45)

func _anim():
	if (Input.is_action_pressed("down")):
		animSprite.play("down")
	elif(Input.is_action_pressed("up")):
		animSprite.play("up")
	elif(Input.is_action_pressed("left")):
		animSprite.play("left")
	elif(Input.is_action_pressed("right")):
		animSprite.play("right")

func ventouse_atck(mouse_pos):
	var atck_instance = ventouse_preload.instantiate()
	add_child(atck_instance)
	atck_instance.position = position
	if (mouse_pos.x > 500):
		atck_instance.position = Vector3(0.300, -0.200, 0)
	else:
		atck_instance.position = Vector3(-0.300, -0.200, 0)

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	var direction_face_camera = camera.global_transform.basis.z
	var distance_mur: float = 5.0
	var position_du_mur = torch_light.global_position - (direction_face_camera * distance_mur)
	var plane = Plane(direction_face_camera, position_du_mur)
	var intersection = plane.intersects_ray(ray_origin, ray_dir)
	if intersection:
		torch_light.look_at(intersection, Vector3.UP)
		torch_light.rotation.z = 0
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	var direction:Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if (direction):
		_anim()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		animSprite.stop()
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
	if (Input.is_action_pressed("leftClick")):
		ventouse_atck(mouse_pos)
	if (Input.is_action_just_pressed("h")):
		$SpringArm3D/Camera3D/Control/HelpMenu.visible = !$SpringArm3D/Camera3D/Control/HelpMenu.visible
		$SpringArm3D/Camera3D/Control/HelpMenu/AnimatedSprite2D.play("help")
	_torch_blink()
	move_and_slide()

func _on_camera_rotation_cooldown_timeout() -> void:
	canrotate = true

func _torch_blink():
	torch_count = randi()
	if (torch_blink == true):
		if (torch_count % 2 == 0):
			torch_light.light_energy = 0
		else:
			torch_light.light_energy = 1

func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.is_in_group("monstre") && torch_blink == false):
		torch_blink = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if (body.is_in_group("monstre")):
		torch_blink = false
