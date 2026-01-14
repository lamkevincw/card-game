extends Node

@onready var error_message_scene = load("res://nodes/floating_error_message.tscn")

@export var player_money : int = 50

@export var search_money_value : int = 15
@export var search_money_duration : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_money(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%SearchMoneyProgressBar.value = (%SearchMoneyTimer.wait_time - %SearchMoneyTimer.time_left) / %SearchMoneyTimer.wait_time * 100
	if (%SearchMoneyTimer.time_left > 0):
		%SearchMoneyLabel.text = str(roundf(%SearchMoneyTimer.time_left * 10) / 10) + " s"
	pass

func change_money(delta: int):
	player_money += delta
	%PlayerMoneyLabel.text = str(player_money)

func money_error():
	var error = error_message_scene.instantiate()
	get_node("/root/Main/CanvasLayer").add_child(error)

func _on_search_money_button_pressed() -> void:
	%SearchMoneyTimer.start()
	%SearchMoneyButton.disabled = true
	pass # Replace with function body.


func _on_search_money_timer_timeout() -> void:
	%SearchMoneyButton.disabled = false
	%SearchMoneyLabel.text = str(search_money_duration) + " s"
	
	change_money(search_money_value)
	pass # Replace with function body.
