extends Area3D

# Cette variable se souvient si le joueur est dans la zone ou non
var joueur_dans_la_zone: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited) # On connecte aussi la sortie de zone

func _process(delta: float) -> void:
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
	var noeud_son
	if (Var.SolarFrag != 4)	:
		noeud_son = self.get_parent().get_node("SoleilRecup")
	else :
		noeud_son = self.get_parent().get_node("SoleilComplet")
	noeud_son.reparent(get_tree().current_scene)   
	noeud_son.play()
	noeud_son.finished.connect(noeud_son.queue_free)
	self.get_parent().queue_free()
