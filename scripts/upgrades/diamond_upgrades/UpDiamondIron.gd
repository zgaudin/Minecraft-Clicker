class_name UpDiamondIron
extends Upgrade
## Upgrade 01 - Increases gold each Second

## Load level data
func _init() -> void:
	level = Game.ref.data.diamond_iron
	title = "Diamond Sword"
	base_cost = 2
	calculate_cost()

func description() -> String:
	var description : String = "Increase Iron based on Diamonds"
	description += "\nEffects : * .1Diamonds / Level"
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
		Game.ref.data.diamond_iron = level
		
		calculate_cost()
		
		leveled_up.emit()
