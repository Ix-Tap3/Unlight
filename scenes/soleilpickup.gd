extends Area3D

# Cette variable se souvient si le joueur est dans la zone ou non
var joueur_dans_la_zone: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited) # On connecte aussi la sortie de zone

func _process(delta: float) -> void:
	# Le _process tourne en continu, il captera la touche "kill" à n'importe quel moment !
	if joueur_dans_la_zone and Input.is_action_just_pressed("kill"):
		_ramasser_item()

func _on_area_entered(area) -> void:
	if area.is_in_group("player"):
		print("Le joueur est entré dans la zone")
		joueur_dans_la_zone = true

func _on_area_exited(area) -> void:
	if area.is_in_group("player"):
		print("Le joueur est sorti de la zone")
		joueur_dans_la_zone = false

func _ramasser_item() -> void:
	Var.SolarFrag += 1
	print("Item ramassé ! Score : ", Var.SolarFrag)
	self.get_parent().queue_free()
