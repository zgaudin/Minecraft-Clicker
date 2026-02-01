class_name UpGoldDouble
extends Upgrade
## Upgrade 03 (Gold) - Increases Chance for Double Gold

## Load level data
func _init() -> void:
	level = Game.ref.data.gold_double_level
	title = "Gold Tools"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Increase chance of doubling gold every click."
	description += "\nEffects : +1%"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(1.3, level))



func can_afford() -> bool:
	if HandlerGold.ref.gold() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerGold.ref.consume_gold(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.gold_double_level = level

		
		calculate_cost()
		
		leveled_up.emit()
