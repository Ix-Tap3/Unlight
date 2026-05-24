extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$sprite.play("atck")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if (body.is_in_group("monstre")):
		body.visible = true


func _on_timer_timeout() -> void:
	
	queue_free()
