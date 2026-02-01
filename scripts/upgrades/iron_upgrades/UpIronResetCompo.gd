class_name UpIronResetCompo
extends Control
## Component Displaying an Upgrade

## Reference to the stuff in the upgrade box
@export var label_title : Label
@export var label_description : RichTextLabel
@export var button : Button

## Upgrade tthat is displayed
var upgrade : Upgrade

##audio stuff
@onready var audio = $MarginContainer/HBoxContainer/Buy/AudioStreamPlayer2D


func _ready() -> void:
	if not upgrade:
		upgrade = UpIronReset.new()
	
	update_label_title()
	update_label_description()
	update_button()
	
	HandlerIron.ref.iron_created.connect(update_button)
	HandlerIron.ref.iron_consumed.connect(update_button)
	
	upgrade.leveled_up.connect(update_label_title)
	upgrade.leveled_up.connect(update_label_description)
	upgrade.leveled_up.connect(update_button)


func update_label_title() -> void:
	var text : String = upgrade.title + " (%s)" %upgrade.level
	label_title.text = text


func update_label_description() -> void:
	label_description.text = upgrade.description()


func update_button(_quantity : int = -1) -> void:
	if Game.ref.data.iron_reset_level == 1:
		Game.ref.data.iron_reset_level = 0
		return
	elif upgrade.can_afford():
		button.disabled = false
		return
	
	
	button.disabled = true


func _on_buy_pressed() -> void:
	HandlerDiamond.ref.create_diamond(HandlerIron.ref.iron()/1000)
	audio.play()
	upgrade.level_up()
