extends Node3D

@export var has_ls : bool = false
@onready var light : SpotLight3D = $Light
@onready var LitArea : Area3D = $LitArea
@onready var PARTICULE : GPUParticles3D = $particule
@onready var OMNI : OmniLight3D = $OmniLight3D
@onready var lamp_mesh = $OmniLight3D/Cube
func _ready() -> void:
	if (has_ls):
		light.light_energy = Var.lightPower
		OMNI.light_energy = Var.lightPower
	else :
		light.light_energy = 0
		OMNI.light_energy = 0
	PARTICULE.emitting = false 

func give_ls() -> void:
	has_ls = true
	light.light_energy = Var.lightPower
	PARTICULE.emitting = true
	OMNI.light_energy = Var.lightPower
	var myobjects = LitArea.get_overlapping_bodies()
	if $Lamp.get_child_count() > 0:
		var mesh_blender = $Lamp.get_child(0) as MeshInstance3D
		if mesh_blender:
			var mat_allume = StandardMaterial3D.new()
			mat_allume.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			mesh_blender.material_override = mat_allume
	for obj in myobjects:
		if (obj.is_in_group("lightreactive")):
			if obj.has_method("set_lit"):
				obj.set_lit()
	
func take_ls() -> void:
	has_ls = false
	light.light_energy = 0
	OMNI.light_energy = 0
	PARTICULE.emitting = false
	var myobjects = LitArea.get_overlapping_bodies()
	if $Lamp.get_child_count() > 0:
		var mesh_blender = $Lamp.get_child(0) as MeshInstance3D
		if mesh_blender:
			mesh_blender.material_override = null # Remet le matériau Blender de base
	for obj in myobjects:
		if (obj.is_in_group("lightreactive")):
			if obj.has_method("set_unlit"):
				obj.set_unlit()
