extends PanelContainer

@export var cards_to_draw : int = 5
@export var draw_cost : int = 10
@export var card_base_cooldown : float = 5.0

var automating : bool = false

# Achievements
var firstDraw : bool = true
var cooldownSecondsFromAchieves : int = 0

# Upgrades
var cooldownSecondsFromUpgrades : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%DrawProgressBar.value = (%DrawCardCooldownTimer.wait_time - %DrawCardCooldownTimer.time_left) / %DrawCardCooldownTimer.wait_time * 100


func _on_draw_button_pressed() -> void:
	if (%Money.player_money >= draw_cost):
		startDrawCooldown()
		%DrawButton.disabled = true
		clearCards()
		%Money.change_money(-draw_cost)
	else:
		%Money.money_error()

func startDrawCooldown():
	# Determine the drawing cooldown
	%DrawCardCooldownTimer.wait_time = card_base_cooldown - (float(cooldownSecondsFromAchieves) * 1.0) - (float(cooldownSecondsFromUpgrades) * 1.0)
	
	# Create individual timers to load cards evenly during the cooldown
	var interval = %DrawCardCooldownTimer.wait_time / cards_to_draw
	for i in range(cards_to_draw):
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = interval * (i + 1)
		timer.one_shot = true
		timer.timeout.connect(_on_draw_timer_timeout)
		timer.start()
	%DrawCardCooldownTimer.start()

func clearCards():
	var children = %CardContainer.get_children()
	for child in children:
		child.free()

func setCooldownAchieves(seconds: int):
	# Achievements
	cooldownSecondsFromAchieves = seconds

func setCooldownUpgrades(seconds: int):
	cooldownSecondsFromUpgrades = seconds

func _on_draw_timer_timeout() -> void:
	$PlayingCardDeck.drawCard()
	%AchievementContainer.checkAchievements()

func _on_draw_card_cooldown_timer_timeout() -> void:
	if automating:
		# Adds a 0.5s timer so that the last card can be seen
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 0.5
		timer.one_shot = true
		#var pressButton = func(): call("_on_draw_button_pressed")
		timer.timeout.connect(_on_draw_button_pressed)
		timer.start()
	else:
		%DrawButton.disabled = false

func _on_check_box_toggled(toggled_on: bool) -> void:
	automating = toggled_on
