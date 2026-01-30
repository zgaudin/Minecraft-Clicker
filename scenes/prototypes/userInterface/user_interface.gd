class_name UserInterface
extends Control

##audio stuff
@onready var audio = $AudioStreamPlayer2D


enum Views {
	PROTOTYPE_GENERATOR,
	PROTOTYPE_CLICKER,
	PROTOTYPE_UPGRADES,
	IRON,
	DIAMOND,
}

signal navigation_requested(view : Views)


func _on_generator_pressed() -> void:
	audio.play()
	navigation_requested.emit(Views.PROTOTYPE_CLICKER)


func _on_clicker_pressed() -> void:
	audio.play()
	navigation_requested.emit(Views.PROTOTYPE_GENERATOR)


func _on_upgrades_pressed() -> void:
	audio.play()
	navigation_requested.emit(Views.PROTOTYPE_UPGRADES)


func _on_iron_pressed() -> void:
	audio.play()
	navigation_requested.emit(Views.IRON)


func _on_diamond_pressed() -> void:
	audio.play()
	navigation_requested.emit(Views.DIAMOND)
