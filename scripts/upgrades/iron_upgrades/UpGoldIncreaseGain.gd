class_name UpGoldIncreaseGain
extends Upgrade

## Load level data
func _init() -> void:
	level = Game.ref.data.gold_increase_gain
	title = "Iron Tools"
	base_cost = 100
	calculate_cost()

func description() -> String:
	var description : String = "Gold increases gold gain."
	description += "\nEffects : * log(Level * Gold) / Level"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(5, level))



func can_afford() -> bool:
	if HandlerIron.ref.iron() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerIron.ref.consume_iron(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.gold_increase_gain = level

		
		calculate_cost()
		
		leveled_up.emit()
