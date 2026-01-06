extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/DrawProgressBar.value = ($CooldownTimer.wait_time - $CooldownTimer.time_left) / $CooldownTimer.wait_time * 100

func _on_draw_button_pressed() -> void:
	startDrawCooldown()
	
	

func startDrawCooldown():
	$CanvasLayer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/DrawProgressBar.value = 0
	$CooldownTimer.start()


func _on_cooldown_timer_timeout() -> void:
	$PlayingCardDeck.drawCard()
	pass # Replace with function body.
