class_name HandlerIron
extends Node

#singleton reference
static var ref : HandlerIron

#singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()


signal iron_created(quantity : int)

signal iron_consumed(quantity : int)


func iron() -> int:
	return Game.ref.data.iron


func create_iron(quantity : int) -> void:
	Game.ref.data.iron += quantity
	iron_created.emit(quantity)


func consume_iron(quantity : int) -> Error:
	if quantity > Game.ref.data.iron:
		return Error.FAILED
	
	Game.ref.data.iron -= quantity
	iron_consumed.emit(quantity)
	
	return Error.OK

func trigger_clicker() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_02_level)
	if Game.ref.data.up_02_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_02_levelInterval)
	
	
	create_iron(quantity)

func trigger_generator() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_02_levelG)
	if Game.ref.data.up_02_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_02_levelInterval)
	
	create_iron(quantity)
