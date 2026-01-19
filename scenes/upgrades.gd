extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func checkCost(cost: int) -> bool:
	if %Money.player_money >= cost:
		%Money.change_money(-cost)
		return true
	else:
		%Money.money_error()
		return false

func _on_unlock_rarity_button_pressed() -> void:
	var cost : int = 5
	if checkCost(cost):
		$VBoxContainer/UpgradesContainer/VBoxContainer/UnlockRarityButton.disabled = true


func _on_increase_refund_button_pressed() -> void:
	var cost : int = 50
	if checkCost(cost):
		%PlayingCardDeck.changeRefund(1)
		$VBoxContainer/UpgradesContainer/VBoxContainer2/IncreaseRefundButton.disabled = true


func _on_decrease_search_cooldown_button_pressed() -> void:
	var cost : int = 200
	if checkCost(cost):
		%WorkContainer.setSearchUpgrades(2)
		$VBoxContainer/UpgradesContainer/VBoxContainer4/DecreaseSearchCooldownButton.disabled = true


func _on_decrease_draw_cooldown_button_pressed() -> void:
	var cost : int = 300
	if checkCost(cost):
		%PlayCardsContainer.setCooldownUpgrades(1)
		$VBoxContainer/UpgradesContainer/VBoxContainer3/DecreaseDrawCooldownButton.disabled = true


func _on_unlock_busk_button_pressed() -> void:
	var cost : int = 500
	if checkCost(cost):
		%AutomateSearchCheckBox.disabled = false
		%BuskContainer.show()
		$VBoxContainer/UpgradesContainer/VBoxContainer5/UnlockBuskButton.disabled = true
