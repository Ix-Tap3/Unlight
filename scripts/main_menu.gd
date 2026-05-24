extends Control

func _on_start_pressed() -> void:
	# 1. On récupère le nœud de la musique
	var musique = $MusiqueGameJam
	musique.reparent(get_tree().root)   
	get_tree().change_scene_to_file("res://scenes/school.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
