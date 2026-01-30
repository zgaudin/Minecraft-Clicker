class_name CompoUpgrade8
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
		upgrade = UnlockDiamond.new()
	
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
	if Game.ref.data.up_01_unlockDiamond == 1:
		return
	elif upgrade.can_afford():
		button.disabled = false
		return
	
	
	button.disabled = true


func _on_buy_pressed() -> void:
	audio.play()
	upgrade.level_up()
