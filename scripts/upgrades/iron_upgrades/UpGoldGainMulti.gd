class_name UpGoldGainMulti
extends Upgrade
## Upgrade 02 (Iron) - Multiplies Gold Gain Compounding

## Load level data
func _init() -> void:
	level = Game.ref.data.gold_gain_multi
	title = "Iron Leggings and Boots"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Multiply Gold Gain Compounding"
	description += "\nEffects : * 1.2 ^ (Level) / Level "
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(1.5, level))



func can_afford() -> bool:
	if HandlerIron.ref.iron() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerIron.ref.consume_iron(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.gold_gain_multi = level
		
		calculate_cost()
		
		leveled_up.emit()
