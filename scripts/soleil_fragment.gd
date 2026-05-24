extends Node3D

@export var vitesse_rotation : float = 0.6
@export var vitesse_flottaison : float = 1
@export var amplitude_flottaison : float = 0.12
@onready var texture :MeshInstance3D = $Cube
var position_initiale : Vector3
var temps_passe : float = 0.0

func _ready() -> void:
	position_initiale.y = $Cube.position.y

func _process(delta: float) -> void:
	rotate_y(vitesse_rotation * delta)
	temps_passe += delta
	$Cube.position.y = position_initiale.y + sin(temps_passe * vitesse_flottaison) * amplitude_flottaison
