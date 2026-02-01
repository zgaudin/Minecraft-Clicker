class_name PrototypeGenerator
extends View


@export var button : Button
@export var timer : Timer

@onready var animation: GeneratorAnimation = $GeneratorButton


func _ready() -> void:
	super()
	visible = false


func create_gold() -> void:
	HandlerGold.ref.trigger_generator()
	

func create_iron() -> void:
	HandlerIron.ref.trigger_generator()


func begin_generating() -> void:
	timer.start()
	button.disabled = true


func _on_button_pressed() -> void:
	begin_generating()


func _on_timer_timeout() -> void:
	create_gold()
	if Game.ref.data.up_01_unlockIron == 1:
		create_iron()
	animation.Animate()
