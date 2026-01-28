class_name HandlerDiamond
extends Node

#singleton reference
static var ref : HandlerDiamond

#singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()


signal diamond_created(quantity : int)

signal diamond_consumed(quantity : int)


func diamond() -> int:
	return Game.ref.data.diamond


func create_diamond(quantity : int) -> void:
	Game.ref.data.diamond += quantity
	diamond_created.emit(quantity)


func consume_diamond(quantity : int) -> Error:
	if quantity > Game.ref.data.diamond:
		return Error.FAILED
	
	Game.ref.data.diamond -= quantity
	diamond_consumed.emit(quantity)
	
	return Error.OK

func trigger_clicker() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_03_level)
	if Game.ref.data.up_03_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_03_levelInterval)
	
	
	create_diamond(quantity)

func trigger_generator() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_03_levelG)
	if Game.ref.data.up_03_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_03_levelInterval)
	
	create_diamond(quantity)
