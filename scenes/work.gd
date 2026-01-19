extends PanelContainer

@export var search_money_value : int = 30
@export var base_search_money_duration : float = 10.0
@export var busk_value : int = 100
@export var base_bask_duration : float = 15.0

var searchDurationUpgrades : int = 0
var buskDurationUpgrades : int = 0

# Automation
var automatingSearch : bool = false
var automatingBusk : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SearchMoneyValue.text = "$" + str(search_money_value)
	%BuskValue.text = "$" + str(busk_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%SearchMoneyProgressBar.value = (%SearchMoneyTimer.wait_time - %SearchMoneyTimer.time_left) / %SearchMoneyTimer.wait_time * 100
	if (%SearchMoneyTimer.time_left > 0):
		%SearchMoneyLabel.text = str(roundf(%SearchMoneyTimer.time_left * 10) / 10) + " s"
	
	%BuskProgressBar.value = (%BuskTimer.wait_time - %BuskTimer.time_left) / %BuskTimer.wait_time * 100
	if (%BuskTimer.time_left > 0):
		%BuskLabel.text = str(roundf(%BuskTimer.time_left * 10) / 10) + " s"

func setSearchUpgrades(seconds: int):
	searchDurationUpgrades = seconds
	var newDuration = base_search_money_duration - (float(searchDurationUpgrades) * 1.0)
	%SearchMoneyLabel.text = str(newDuration) + " s"

func setBuskUpgrades(seconds: int):
	buskDurationUpgrades = seconds
	var newDuration = base_bask_duration - (float(buskDurationUpgrades) * 1.0)
	%BuskLabel.text = str(newDuration) + " s"

func _on_search_money_button_pressed() -> void:
	%SearchMoneyTimer.wait_time = base_search_money_duration - (float(searchDurationUpgrades) * 1.0)
	
	%SearchMoneyTimer.start()
	%SearchMoneyButton.disabled = true

func _on_search_money_timer_timeout() -> void:
	%SearchMoneyLabel.text = str(%SearchMoneyTimer.wait_time) + " s"
	
	%StatisticsContainer.add_money_earned(search_money_value)
	%Money.change_money(search_money_value)
	
	if automatingSearch:
		_on_search_money_button_pressed()
	else:
		%SearchMoneyButton.disabled = false

func _on_automate_search_check_box_toggled(toggled_on: bool) -> void:
	automatingSearch = toggled_on


func _on_busk_button_pressed() -> void:
	%BuskTimer.wait_time = base_bask_duration - (float(buskDurationUpgrades) * 1.0)
	
	%BuskTimer.start()
	%BuskButton.disabled = true

func _on_busk_timer_timeout() -> void:
	%BuskLabel.text = str(%BuskTimer.wait_time) + " s"
	
	%StatisticsContainer.add_money_earned(busk_value)
	%Money.change_money(busk_value)
	
	if automatingBusk:
		_on_busk_button_pressed()
	else:
		%BuskButton.disabled = false

func _on_automate_busk_check_box_toggled(toggled_on: bool) -> void:
	automatingBusk = toggled_on
