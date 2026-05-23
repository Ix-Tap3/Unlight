extends Node3D

@export var has_ls : bool = false
@onready var light : SpotLight3D = $Light
@onready var LitArea : Area3D = $LitArea

func _ready() -> void:
	if (has_ls):
		light.light_energy = Var.lightPower
	else :
		light.light_energy = 0

func give_ls() -> void:
	has_ls = true
	light.light_energy = Var.lightPower
	var myobjects = LitArea.get_overlapping_areas()
	for obj in myobjects:
		if (obj.is_in_group("lightreactive")):
			obj.set_lit()
	
func take_ls() -> void:
	has_ls = false
	light.light_energy = 0
	var myobjects = LitArea.get_overlapping_areas()
	for obj in myobjects:
		if (obj.is_in_group("lightreactive")):
			obj.set_unlit()


	
