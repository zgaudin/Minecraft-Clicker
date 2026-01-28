class_name PrototypeClicker
extends View

var tween: Tween

@export var button : Button

func _ready() -> void:
	super()
	visible = true
	
	pivot_offset = size / 2



func create_gold() -> void:
	var rand : int
	rand = randi_range(0, 10)
	
	if rand == 0 && Game.ref.data.up_01_unlockDiamond == 1:
		HandlerDiamond.ref.trigger_clicker()
		button.icon = ResourceLoader.load("res://Images/Diamond_JE3_BE3.png")
	
	elif rand == 1 && Game.ref.data.up_01_unlockIron == 1 || rand == 2 && Game.ref.data.up_01_unlockIron == 1:
		HandlerIron.ref.trigger_clicker()
		button.icon = ResourceLoader.load("res://Images/Iron_Ingot_JE3_BE2.png")
		
	else:
		HandlerGold.ref.trigger_clicker()
		button.icon = ResourceLoader.load("res://Images/Gold_Ingot_JE4_BE2.png")


func _on_button_pressed() -> void:
	create_gold()
