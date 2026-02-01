class_name UpCps
extends Upgrade
## Upgrade 01 - Clicks gold X times each second

## Load level data
func _init() -> void:
	level = Game.ref.data.cps_level
	title = "Iron Helmet and Chestplate"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Clicks Gold X times each second."
	description += "\nEffects : +1 cps / Level"
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
		Game.ref.data.cps_level = level
		
		
		calculate_cost()
		
		leveled_up.emit()
