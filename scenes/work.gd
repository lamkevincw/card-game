extends PanelContainer

@export var search_money_value : int = 30
@export var search_money_duration : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SearchMoneyValue.text = "$" + str(search_money_value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%SearchMoneyProgressBar.value = (%SearchMoneyTimer.wait_time - %SearchMoneyTimer.time_left) / %SearchMoneyTimer.wait_time * 100
	if (%SearchMoneyTimer.time_left > 0):
		%SearchMoneyLabel.text = str(roundf(%SearchMoneyTimer.time_left * 10) / 10) + " s"
	pass

func _on_search_money_button_pressed() -> void:
	%SearchMoneyTimer.start()
	%SearchMoneyButton.disabled = true
	pass # Replace with function body.

func _on_search_money_timer_timeout() -> void:
	%SearchMoneyButton.disabled = false
	%SearchMoneyLabel.text = str(search_money_duration) + " s"
	
	%StatisticsContainer.add_money_earned(search_money_value)
	%Money.change_money(search_money_value)
	pass # Replace with function body.
