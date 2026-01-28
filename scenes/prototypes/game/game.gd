class_name Game
extends Node

#singleton reference
static var ref : Game

#singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()

@export var scene_user_interface : PackedScene

var data : Data

func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()

func _ready() -> void:
	var node_user_interface : UserInterface = scene_user_interface.instantiate() as UserInterface
	add_child(node_user_interface)
