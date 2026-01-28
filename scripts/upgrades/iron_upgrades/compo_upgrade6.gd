class_name CompoUpgrade6
extends Control
## Component Displaying an Upgrade

## Reference to the stuff in the upgrade box
@export var label_title : Label
@export var label_description : RichTextLabel
@export var button : Button

## Upgrade tthat is displayed
var upgrade : Upgrade


func _ready() -> void:
	if not upgrade:
		upgrade = Upgrade02GeneratorUpgrade.new()
	
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
	if upgrade.can_afford():
		button.disabled = false
		return
	
	button.disabled = true


func _on_buy_pressed() -> void:
	upgrade.level_up()
