extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position() + Vector2(10.0, -30.0)
	pass


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
