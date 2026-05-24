extends Area3D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area) -> void:
	print("test")
	if area.is_in_group("player"):
		_ramasser_item()

func _ramasser_item() -> void:
	Var.SolarFrag += 1
	self.get_parent().queue_free()
