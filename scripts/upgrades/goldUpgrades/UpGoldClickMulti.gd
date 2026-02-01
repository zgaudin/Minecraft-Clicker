class_name UpGoldClickMulti
extends Upgrade
## Upgrade 02 (Gold) - Multiplies Gold Per Click

## Load level data
func _init() -> void:
	level = Game.ref.data.click_multi_level
	title = "Gold Leggings and Boots"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Multiplies Gold Per Click."
	description += "\nEffects : *1.2 Gold / Level"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(1.5, level))



func can_afford() -> bool:
	if HandlerGold.ref.gold() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerGold.ref.consume_gold(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.click_multi_level = level
		
		calculate_cost()
		
		leveled_up.emit()
