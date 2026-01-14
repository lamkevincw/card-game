extends PanelContainer

var achievements = ["1 Suit", "3 Suits", "Full Deck"]

@onready var tileScene = load("res://nodes/achievement_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_json()
	initializeTiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func read_json():
	var f = FileAccess.get_file_as_string("res://assets/achievements.json")
	achievements = JSON.parse_string(f)

func initializeTiles():
	for i in range(achievements.size()):
		var newTile = tileScene.instantiate()
		newTile.setLabel(str(i + 1))
		newTile.achievement = achievements[i]
		%AchievementGrid.add_child(newTile)
