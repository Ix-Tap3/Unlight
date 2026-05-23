extends Node3D

@export var has_ls : bool = false
@onready var light : SpotLight3D = $Light
func _ready() -> void:
	if (has_ls):
		light.light_energy = Var.lightPower
	else :
		light.light_energy = 0

func give_ls() -> void:
	has_ls = true
	light.light_energy = Var.lightPower
	
func take_ls() -> void:
	has_ls = false
	light.light_energy = 0

	
