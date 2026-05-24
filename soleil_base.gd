extends Node3D

@onready var basic_cube : MeshInstance3D = $Cube_001
var nb_fraglocal : int = 1
@onready var light : SpotLight3D = $SpotLight3D
func _process(delta: float) -> void:
	if nb_fraglocal != Var.SolarFrag:
		print("SOLEIL")
		
		# 1. On crée un matériel jaune parfait directement en code
		var jaune_soleil = StandardMaterial3D.new()
		jaune_soleil.albedo_color = Color(1.0, 0.9, 0.0) # Un beau Jaune vif
		jaune_soleil.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED # Ignore la lumière
		
		# 2. On applique la logique selon le nombre de fragments
		if Var.SolarFrag == 2:
			light.spot_range = 20
			light.light_energy += 1
			$Cube_002.material_override = jaune_soleil
			nb_fraglocal = 2
			
		elif Var.SolarFrag == 3:
			light.spot_range = 50
			light.light_energy += 2
			$Cube_003.material_override = jaune_soleil
			nb_fraglocal = 3
			
		elif Var.SolarFrag == 4:
			light.spot_range = 100
			light.light_energy += 2
			$Cube_004.material_override = jaune_soleil
			nb_fraglocal = 4
