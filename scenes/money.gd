extends Node

@onready var error_message_scene = load("res://nodes/floating_error_message.tscn")

@export var player_money : int = 50



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_money(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save() -> Dictionary:
	var save_dict = {
		"player_money" : player_money
	}
	return save_dict

func change_money(delta: int):
	player_money += delta
	%PlayerMoneyLabel.text = str(player_money)

func money_error():
	var error = error_message_scene.instantiate()
	get_node("/root/Main/CanvasLayer").add_child(error)
