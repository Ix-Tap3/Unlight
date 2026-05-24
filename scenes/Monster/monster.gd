extends CharacterBody3D

const SOLEIL_SCENE = preload("res://scenes/soleil_fragment.tscn")
@onready var myarea: Area3D = $Area3D

# Cette variable passe à true dès que l'Area3D du joueur entre dans myarea
var joueur_dans_la_zone: bool = false

func _ready() -> void:
	$Sprite3D.play("default")
	# On connecte les signaux d'Area à Area
	myarea.area_entered.connect(_on_area_entered)
	myarea.area_exited.connect(_on_area_exited)

func _physics_process(delta: float) -> void:
	# Gravité pour ton CharacterBody3D
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _process(delta: float) -> void:
	# On écoute le clavier de manière ultra-précise ici
	if self.visible and joueur_dans_la_zone:
		if Input.is_action_just_pressed("kill"):
			executer_remplacement()

func _on_area_entered(area: Area3D) -> void:
	# On vérifie si l'Area3D qui entre est celle du joueur (ou est dans le groupe)
	if area.is_in_group("player") or area.get_parent().is_in_group("player"):
		joueur_dans_la_zone = true

func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("player") or area.get_parent().is_in_group("player"):
		joueur_dans_la_zone = false

func executer_remplacement() -> void:
	var instance = SOLEIL_SCENE.instantiate()
	var position_actuelle = self.global_position
	
	get_parent().add_child(instance)
	instance.global_position = position_actuelle + Vector3(0, 0.001, 0)
	
	queue_free()
