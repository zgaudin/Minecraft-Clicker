class_name UnlockIron
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_01_level
	title = "Iron Block"
	base_cost = 50000
	calculate_cost()

func description() -> String:
	var description : String = "Unlock Iron"
	description += "\nEffects : Unlock Iron"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(10, level))



func can_afford() -> bool:
	if HandlerGold.ref.gold() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	if Game.ref.data.up_01_unlockIron == 1:
		return
	var error : Error = HandlerGold.ref.consume_gold(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_01_unlockIron = level

		
		calculate_cost()
		
		leveled_up.emit()
