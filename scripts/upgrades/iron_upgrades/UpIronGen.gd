class_name UpIronGen
extends Upgrade

## Load level data
func _init() -> void:
	level = Game.ref.data.iron_gen
	title = "Iron Helmet and Chestplate"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Generate Iron per second."
	description += "\nEffects : Level * 5% (Total Iron)  / Level"
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
		Game.ref.data.iron_gen = level
		
		
		calculate_cost()
		
		leveled_up.emit()
