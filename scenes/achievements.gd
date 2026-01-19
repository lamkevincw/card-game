extends PanelContainer

var achievements = []
var achieveTiles = []
var achieved : Array[bool] = []

@onready var tileScene = load("res://nodes/achievement_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_json()
	initializeTiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save() -> Dictionary:
	var save_dict = {
		"achievements": achieved
	}
	return save_dict

func read_json():
	var f = FileAccess.get_file_as_string("res://assets/achievements.json")
	achievements = JSON.parse_string(f)
	achieveTiles.resize(achievements.size())
	achieved.resize(achievements.size())

func initializeTiles():
	for i in range(achievements.size()):
		var newTile = tileScene.instantiate()
		newTile.setLabel(str(i + 1))
		newTile.achievement = achievements[i]
		
		achieveTiles[i] = newTile
		%AchievementGrid.add_child(newTile)

func setAchievement(id: int):
	achieveTiles[id].setAchieved()

func checkAchievements():
	# Check based on card draws
	if (%StatisticsContainer.draws > 5):
		setAchievement(0)
		%CollectionButton.disabled = false
		%AchievementButton.disabled = false
		%StatisticsButton.disabled = false
		%WorkButton.show()
	if (%StatisticsContainer.draws > 15):
		setAchievement(1)
		%WorkButton.disabled = false
	
	# Check how many suits are collected
	var suitsCollected = 0
	for i in range(%PlayingCardDeck.collectedSuits.size()):
		if !%PlayingCardDeck.collectedSuits[i]:
			var filledSuit = true
			for j in range(i * 13, 13 + i * 13):
				if %PlayingCardDeck.card_collection[j] == "":
					filledSuit = false
			%PlayingCardDeck.collectedSuits[i] = filledSuit
		if %PlayingCardDeck.collectedSuits[i]:
			suitsCollected += 1
	
	var oneSecCooldown : int = 0
	if (suitsCollected >= 2): # 2 suits collected
		setAchievement(3)
		oneSecCooldown += 1

	# Check collection progress
	if (float(%PlayingCardDeck.collectionProgress) / float(%PlayingCardDeck.full_deck.size()) > 0.5):
		setAchievement(2)
		oneSecCooldown += 1
	if (%PlayingCardDeck.collectionProgress == 51):
		setAchievement(4)
		%PlayingCardDeck.onLastOne = true
	if (%PlayingCardDeck.collectionProgress == 52):
		setAchievement(5)
		%PlayingCardDeck.onLastOne = false
		%AutomatePlayCardsCheckBox.disabled = false
	
	# Processes draw cooldown reduction
	%PlayCardsContainer.setCooldownAchieves(oneSecCooldown)
