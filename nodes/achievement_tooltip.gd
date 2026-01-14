extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position() + Vector2(10.0, -30.0)
	pass

func set_name_text(text: String):
	%NameLabel.text = text

func set_description_text(text: String):
	%DescriptionLabel.text = text

func set_bonus_text(text: String):
	%BonusLabel.text = text

func isAchieved(achieved: bool):
	if achieved:
		%BonusLabel.show()
	else:
		%BonusLabel.hide()
