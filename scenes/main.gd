extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save():
	var save_dict : Dictionary
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		var node_data = node.call("save")
		save_dict.merge(node_data)
	print(save_dict)

func _on_save_button_pressed() -> void:
	save()
