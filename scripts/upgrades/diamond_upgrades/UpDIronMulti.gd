class_name UpDIronMulti
extends Upgrade

## Load level data
func _init() -> void:
	level = Game.ref.data.diron_multi
	title = "Diamond Helmet and Chestplate"
	base_cost = 2
	calculate_cost()

func description() -> String:
	var description : String = "Multiply iron gain"
	description += "\nEffects : *3 Iron / Level"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(1.5, level))



func can_afford() -> bool:
	if HandlerDiamond.ref.diamond() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerDiamond.ref.consume_diamond(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.diron_multi = level
		
		
		calculate_cost()
		
		leveled_up.emit()
