extends PanelContainer

@export var achievement : Dictionary

@onready var tooltipScene = load("res://nodes/achievement_tooltip.tscn")
var newToolTip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setLabel(label: String):
	$AchievementLabel.text = label


func _on_mouse_entered() -> void:
	newToolTip = tooltipScene.instantiate()
	newToolTip.set_text(achievement.tooltip)
	get_tree().root.get_child(0).get_child(1).add_child(newToolTip)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	newToolTip.queue_free()
	pass # Replace with function body.
