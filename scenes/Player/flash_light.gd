extends SpotLight3D
@onready var laser_ray: RayCast3D = $RayCast3D
@export var has_ls : bool = true
@onready var Cooldown : Timer = $Cooldown

func _ready() -> void:
	pass # Replace with function body.

func give_ls() -> void:
	has_ls = true
	self.light_energy = Var.lightPower
	
func take_ls() -> void:
	has_ls = false
	self.light_energy = 0
	
func _process(delta: float) -> void:
	if laser_ray.is_colliding():
		var objet_touche = laser_ray.get_collider()
		if (objet_touche.is_in_group("lightsource")):
			print("zob")
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
				ressource.give_ls()
				Cooldown.start()
