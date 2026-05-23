extends Area3D

var litstate : bool = false

var cible_position : Vector3

func _ready() -> void:
	cible_position = self.position
	
func _process(delta):
	global_position = global_position.lerp(cible_position, 0.1)
	
func set_lit() -> void:
	litstate = true
	print (self, "is being iluminated")
	cible_position = Vector3(cible_position.x + 1, cible_position.y , cible_position.z)
	
	
func set_unlit() -> void :
	litstate = false
	print (self, "is not being iluminated anymore")
	cible_position = Vector3(cible_position.x - 1, cible_position.y, cible_position.z)
