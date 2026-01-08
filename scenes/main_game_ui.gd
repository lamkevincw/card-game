extends MarginContainer

@onready var play_cards_button: Button = %PlayCardsButton
@onready var collection_button: Button = %CollectionButton
@onready var work_button: Button = %WorkButton
@onready var achievement_button: Button = %AchievementButton


var panels : Array[PanelContainer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panels = [%PlayCardsContainer, %CollectionContainer, %WorkContainer, %AchievementContainer]
	
	play_cards_button.pressed.connect(show_panel.bind(panels[0]))
	collection_button.pressed.connect(show_panel.bind(panels[1]))
	work_button.pressed.connect(show_panel.bind(panels[2]))
	achievement_button.pressed.connect(show_panel.bind(panels[3]))
	
	show_panel(panels[0])
	play_cards_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_panel(panel_to_show: PanelContainer) -> void:
	for panel in panels:
		panel.hide()
	
	panel_to_show.show()
