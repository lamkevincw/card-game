extends Node

var draws : int = 0
var refunds : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func checkAchievements():
	match draws:
		5: # First draw
			%AchievementContainer.setAchievement(0)
			%CollectionButton.disabled = false
			%AchievementButton.disabled = false
			%WorkButton.show()
		15: # Three draws
			%AchievementContainer.setAchievement(1)
			%WorkButton.disabled = false
