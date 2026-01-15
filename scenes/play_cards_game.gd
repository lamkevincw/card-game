extends PanelContainer

@export var cards_to_draw : int = 5
@export var draw_cost : int = 10
@export var card_base_cooldown : float = 5.0

# Achievements
var firstDraw : bool = true

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

func set_card_cooldown(subtract: float):
	# Achievements
	%DrawCardCooldownTimer.wait_time = card_base_cooldown - subtract

func _on_draw_timer_timeout() -> void:
	$PlayingCardDeck.drawCard()
	%StatisticsContainer.checkAchievements()

func _on_draw_card_cooldown_timer_timeout() -> void:
	%DrawButton.disabled = false
