extends Area3D

var litstate : bool = false

	

	
func set_lit() -> void:
	litstate = true
	print (self, "is being iluminated")
	
	
func set_unlit() -> void :
	litstate = false
	print (self, "is not being iluminated anymore")
