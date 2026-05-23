extends MeshInstance3D

var stone = StandardMaterial3D.new()
var school_wall = StandardMaterial3D.new()

func _ready():
	stone.albedo_texture = preload("res://assets/tiles/wall1.png")
	stone.uv1_scale = Vector3(3.0, 2.0, 1.0)
	
	school_wall.albedo_texture = preload("res://assets/tiles/school_wall1.png")
	
	set_surface_override_material(0, stone)
	set_surface_override_material(1, school_wall)
