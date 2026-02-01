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


signal iron_created(quantity : float)

signal iron_consumed(quantity : float)


func iron() -> float:
	return Game.ref.data.iron


func create_iron(quantity : float) -> void:
	Game.ref.data.iron += quantity
	iron_created.emit(quantity)


func consume_iron(quantity : float) -> Error:
	if quantity > Game.ref.data.iron:
		return Error.FAILED
	
	Game.ref.data.iron -= quantity
	iron_consumed.emit(quantity)
	
	return Error.OK

func trigger_clicker() -> void:
	var quantity : float = 0
	quantity = calculate_iron_multiplier()
	
	create_iron(quantity)

func calculate_iron_multiplier() -> float:
	var quantity : float = 1
	
	#IRON UPGRADES --------------
	
	#Iron Multiplier
	if Game.ref.data.iron_multi > 0:
		quantity *= 1.2 * Game.ref.data.iron_multi
	
	#DIAMOND UPGRADES --------------
	
	#DIron Multiplier
	if Game.ref.data.diron_multi > 0:
		quantity *= 3 * Game.ref.data.diron_multi
	
	#Iron Multiplier based on diamond count
	if Game.ref.data.diamond_iron > 0:
		quantity *= (Game.ref.data.diamond_iron * (.1 * Game.ref.data.diamond))
	
	print("Iron Multiplier ", quantity)


	return quantity

func trigger_clicker_gen() -> void:
	var quantity : float = 1
	quantity = calculate_iron_multiplier()
	quantity *= iron() * .05
	
	print(quantity)
	create_iron(quantity)
	
	print(iron())
