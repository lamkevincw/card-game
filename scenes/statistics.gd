extends Node

var time_played : int
var draws : int = 0
var moneyEarned : int = 0
var refunds : int = 0
var refundEarned : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_played = Time.get_ticks_msec() # Time played in milliseconds
	var timeDict = Time.get_time_dict_from_unix_time(time_played / 1000)
	$VBoxContainer/VBoxContainer/TimePlayedContainer/TimePlayedLabel.text = str(timeDict.hour) + ":" + str(timeDict.minute).pad_zeros(2) + ":" + str(timeDict.second).pad_zeros(2)
	pass

func add_draws(value: int):
	draws += value
	$VBoxContainer/VBoxContainer/CardsDrawnContainer/CardsDrawnLabel.text = str(draws)
	print(Time.get_time_dict_from_unix_time(time_played / 1000))

func add_money_earned(value: int):
	moneyEarned += value
	$VBoxContainer/VBoxContainer/MoneyEarnedContainer/MoneyEarnedLabel.text = str(moneyEarned)

func add_refunds(value: int):
	refunds += value
	$VBoxContainer/VBoxContainer/RefundCountContainer/RefundCountLabel.text = str(refunds)

func add_refunds_earned(value: int):
	refundEarned += value
	$VBoxContainer/VBoxContainer/RefundEarnedContainer/RefundEarnedLabel.text = str(refundEarned)

func checkAchievements():
	match draws:
		5: # First draw
			%AchievementContainer.setAchievement(0)
			%CollectionButton.disabled = false
			%AchievementButton.disabled = false
			%StatisticsButton.disabled = false
			%WorkButton.show()
		15: # Three draws
			%AchievementContainer.setAchievement(1)
			%WorkButton.disabled = false
