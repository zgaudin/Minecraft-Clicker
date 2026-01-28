class_name View
extends Control
## Abstract class defining a view

@export var user_interface : UserInterface

@export var view : UserInterface.Views

func _ready() -> void:
	user_interface.navigation_requested.connect(_on_navigation_request)

func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	if requested_view == view:
		visible = true
		return
		
	visible = false
