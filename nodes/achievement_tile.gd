extends PanelContainer

@export var achievement : Dictionary
@export var achieved : bool = false

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

func setAchieved():
	achievement.achieved = true
	achieved = true
	modulate = Color.from_hsv(0, 0, 1, 1)
	

func _on_mouse_entered() -> void:
	newToolTip = tooltipScene.instantiate()
	newToolTip.set_name_text(achievement.name)
	newToolTip.set_description_text(achievement.description)
	newToolTip.set_bonus_text(achievement.bonus)
	newToolTip.isAchieved(achieved)
	
	get_node("/root/Main/CanvasLayer").add_child(newToolTip)
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	newToolTip.queue_free()
	pass # Replace with function body.
