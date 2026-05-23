extends SpotLight3D
@onready var laser_ray: ShapeCast3D = $RayCast3D
@export var has_ls : bool = true
@onready var Cooldown : Timer = $Cooldown
@onready var CooldownResize : Timer = $CoolDownResize
@onready var target_angle: float = spot_angle
@onready var target_range: float = spot_range
@onready var target_energy: float = light_energy
@export var zoom_smoothness: float = 10.0 

func zoom_light() -> void:
	if target_angle > 8:
		target_angle -= 3.2
		target_range += 3.2
		target_energy += 0.2
		laser_ray.scale.z += 0.2

func unzoom_light() -> void:
	if target_angle < 75 and target_energy > 0.33 and target_range < 90:
		target_angle += 3.2
		target_range -= 3.2
		target_energy -= 0.2
		laser_ray.scale.z -= 0.2


func _ready() -> void:
	pass # Replace with function body.
	
func give_ls() -> void:
	has_ls = true
	self.target_energy = Var.lightPower
	
func take_ls() -> void:
	has_ls = false
	self.light_energy = 0
	
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("lightsizeup") && CooldownResize.is_stopped()):
		CooldownResize.start()
		zoom_light()
	if (Input.is_action_just_pressed("lightsizedown")&& CooldownResize.is_stopped()):
		CooldownResize.start()
		unzoom_light()
	if laser_ray.is_colliding():
		var nombre_objets = laser_ray.get_collision_count()
		for i in range(nombre_objets):
			var objet_touche = laser_ray.get_collider(i)
			if (objet_touche.is_in_group("lightsource")):
				var ressource = objet_touche.get_parent()
				print(self.has_ls, ressource.has_ls)
				if (self.has_ls == false && ressource.has_ls == true && Cooldown.is_stopped()):
					print("1")
					self.give_ls()
					ressource.take_ls()
					Cooldown.start()
				if (self.has_ls == true && ressource.has_ls == false && Cooldown.is_stopped()):
					print("2")
					self.take_ls()
					target_energy = 0.0
					ressource.give_ls()
					Cooldown.start()
	spot_angle = lerp(spot_angle, target_angle, zoom_smoothness * delta)
	spot_range = lerp(spot_range, target_range, zoom_smoothness * delta)
	light_energy = lerp(light_energy, target_energy, zoom_smoothness * delta)
