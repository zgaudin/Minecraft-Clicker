class_name Upgrade01ToolUpgrade
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_01_level
	title = "Gold Tools"
	base_cost = 100
	calculate_cost()

func description() -> String:
	var description : String = "Double gold from all sources."
	description += "\nEffects : *2 Gold"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(5, level))



func can_afford() -> bool:
	if HandlerGold.ref.gold() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerGold.ref.consume_gold(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_01_levelInterval = level

		
		calculate_cost()
		
		leveled_up.emit()
