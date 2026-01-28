class_name Upgrade01ClickerUpgrade
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_01_level
	title = "Gold Helmet and Chestplate"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Increases gold obtained each click."
	description += "\nEffects : +1 Gold / Level"
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
		Game.ref.data.up_01_level = level
		
		
		calculate_cost()
		
		leveled_up.emit()
