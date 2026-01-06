extends Node2D

var cards_to_draw : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/DrawProgressBar.value = ($CooldownTimer.wait_time - $CooldownTimer.time_left) / $CooldownTimer.wait_time * 100

func _on_draw_button_pressed() -> void:
	startDrawCooldown()
	$CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/MarginContainer/DrawButton.disabled = true
	clearCards()
	

func startDrawCooldown():
	# Create individual timers to load cards evenly during the cooldown
	var interval = $CooldownTimer.wait_time / cards_to_draw
	for i in range(cards_to_draw):
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = interval * (i + 1)
		timer.one_shot = true
		timer.timeout.connect(_on_draw_timer_timeout)
		timer.start()
	$CooldownTimer.start()

func clearCards():
	var children = $CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/CardContainer.get_children()
	for child in children:
		child.free()

func _on_draw_timer_timeout() -> void:
	$PlayingCardDeck.drawCard()

func _on_cooldown_timer_timeout() -> void:
	$CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/MarginContainer/DrawButton.disabled = false
	pass
