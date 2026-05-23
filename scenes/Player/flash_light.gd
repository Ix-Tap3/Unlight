extends SpotLight3D
@onready var laser_ray: RayCast3D = $RayCast3D

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if laser_ray.is_colliding():
		var objet_touche = laser_ray.get_collider()
		if (objet_touche.is_in_group("lightsource")):
			print("zob")
