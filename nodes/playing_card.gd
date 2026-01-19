extends PanelContainer

@export_range(1, 13) var value : int
@export_enum("Spades", "Clubs", "Hearts", "Diamonds") var suit : String = "Spades"
@export var cardTexture : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_texture(newTexture : Texture):
	cardTexture = newTexture
	$PlayingCardTexture.set_texture(newTexture)

func showRefund():
	$RefundLabel.show()

func changeRefundLabel(value: int):
	$RefundLabel.text = "Refund $" + str(value)
