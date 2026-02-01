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


signal gold_created(quantity : float)

signal gold_consumed(quantity : float)


func gold() -> float:
	return Game.ref.data.gold


func create_gold(quantity : float) -> void:
	Game.ref.data.gold += quantity
	gold_created.emit(quantity)


func consume_gold(quantity : float) -> Error:
	if quantity > Game.ref.data.gold:
		return Error.FAILED
	
	Game.ref.data.gold -= quantity
	gold_consumed.emit(quantity)
	
	return Error.OK

func trigger_clicker() -> void:
	var quantity : float = calculate_overall_multiplier()
	
	create_gold(quantity)

func trigger_generator() -> void:
	var quantity : int = 1
	
	create_gold(quantity)

func calculate_overall_multiplier() -> float:
	var quantity : float = 1.0
	
	#GOLD UPGRADES -----------
	
	#Gold Per Click
	quantity += (Game.ref.data.click_up_level)
	
	
	#Gold Multiplier
	if Game.ref.data.click_multi_level > 0:
		quantity *= (Game.ref.data.click_multi_level * 1.2)
	
	#Chance for Double Gold
	var rand : int
	rand = randi_range(0, 100)
	if Game.ref.data.gold_double_level > rand:
		quantity *= 2
	
	#IRON UPGRADES -----------
	
	#Gold Gain Compound
	quantity *= pow(1.2, Game.ref.data.gold_gain_multi)
	
	#Gold Gain Increases Gold Gain
	if Game.ref.data.gold_increase_gain > 0:
		quantity *= log(Game.ref.data.gold_increase_gain * gold()) 
	
	#DIAMOND UPGRADES -----------
	
	if Game.ref.data.gold_expo > 0:
		quantity += pow(gold(), (1 + (.5 * Game.ref.data.gold_expo)))
	
		print("Gold Multiplier ", quantity)

	return quantity
	
