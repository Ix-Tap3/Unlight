extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.light_energy = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Var.SolarFrag == 4):
		self.light_energy = 5
		self.visible = true
