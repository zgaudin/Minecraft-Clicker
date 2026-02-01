class_name PrototypeClicker
extends View

var tween: Tween

@export var button : Button

##audio stuff
@onready var audio = $Button/AudioStreamPlayer2D

func _ready() -> void:
	super()
	visible = true
	
	pivot_offset = size / 2



func create_gold() -> void:
	var rand : int
	rand = randi_range(0, 10)
	
	HandlerGold.ref.trigger_clicker()



func _on_button_pressed() -> void:
	audio.play()
	create_gold()
