class_name HandlerGold
extends Node

#singleton reference
static var ref : HandlerGold

#singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()


signal gold_created(quantity : int)

signal gold_consumed(quantity : int)


func gold() -> int:
	return Game.ref.data.gold


func create_gold(quantity : int) -> void:
	Game.ref.data.gold += quantity
	gold_created.emit(quantity)


func consume_gold(quantity : int) -> Error:
	if quantity > Game.ref.data.gold:
		return Error.FAILED
	
	Game.ref.data.gold -= quantity
	gold_consumed.emit(quantity)
	
	return Error.OK

func trigger_clicker() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_01_level)
	if Game.ref.data.up_01_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_01_levelInterval)
	if Game.ref.data.up_02_levelGold > 0 :
		quantity *= (2 * Game.ref.data.up_02_levelGold)
	
	
	create_gold(quantity)

func trigger_generator() -> void:
	var quantity : int = 1
	quantity += (Game.ref.data.up_01_levelG)
	if Game.ref.data.up_01_levelInterval > 0 :
		quantity *= (2 * Game.ref.data.up_01_levelInterval)
	if Game.ref.data.up_02_levelGold > 0 :
		quantity *= (2 * Game.ref.data.up_02_levelGold)
	
	create_gold(quantity)
