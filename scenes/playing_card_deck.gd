extends Node

@export var cardContainer : HBoxContainer
@export var drawProgressBar : ProgressBar
var cardScene = load("res://nodes/PlayingCard.tscn")

var full_deck = [
	"Clubs 1", "Clubs 2", "Clubs 3", "Clubs 4", "Clubs 5", "Clubs 6", "Clubs 7", "Clubs 8", "Clubs 9", "Clubs 10", "Clubs 11", "Clubs 12", "Clubs 13", 
	"Diamonds 1", "Diamonds 2", "Diamonds 3", "Diamonds 4", "Diamonds 5", "Diamonds 6", "Diamonds 7", "Diamonds 8", "Diamonds 9", "Diamonds 10", "Diamonds 11", "Diamonds 12", "Diamonds 13", 
	"Hearts 1", "Hearts 2", "Hearts 3", "Hearts 4", "Hearts 5", "Hearts 6", "Hearts 7", "Hearts 8", "Hearts 9", "Hearts 10", "Hearts 11", "Hearts 12", "Hearts 13", 
	"Spades 1", "Spades 2", "Spades 3", "Spades 4", "Spades 5", "Spades 6", "Spades 7", "Spades 8", "Spades 9", "Spades 10", "Spades 11", "Spades 12", "Spades 13"
]
var progressing : bool = false

var card_collection = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_collection.resize(full_deck.size())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (progressing):
		drawProgressBar.value += drawProgressBar.step
		if (drawProgressBar.value == 100):
			progressing = false

func drawCard():
	var cardIndex = randi() % full_deck.size()
	var card = full_deck[cardIndex]
	var collected = (card_collection[cardIndex] != null)
	
	card_collection[cardIndex] = card
	
	print(card_collection)
	
	var cardDict = {"value": card.split(" ")[1], "suit": card.split(" ")[0]}
	match cardDict.value:
		"1":
			cardDict.value = "Ace"
		"11":
			cardDict.value = "Jack"
		"12":
			cardDict.value = "Queen"
		"13":
			cardDict.value = "King"
	
	var newCard = cardScene.instantiate()
	newCard.value = cardDict.value
	newCard.suit = cardDict.suit
	var newTexture = load("res://assets/playing-cards/" + cardDict.value.to_lower() + "_of_" + cardDict.suit.to_lower() + ".png")
	newCard.set_texture(newTexture)
	
	if (collected):
		newCard.modulate = Color.from_hsv(0, 0, 0.4, 1)
	
	
	
	cardContainer.add_child(newCard)
