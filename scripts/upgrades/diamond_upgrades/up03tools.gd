class_name Upgrade03ToolUpgrade
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_03_level
	title = "Diamond Tools"
	base_cost = 500
	calculate_cost()

func description() -> String:
	var description : String = "Double diamond from all sources."
	description += "\nEffects : *2 Diamond"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(5, level))



func can_afford() -> bool:
	if HandlerDiamond.ref.diamond() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerDiamond.ref.consume_diamond(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_03_levelInterval = level

		
		calculate_cost()
		
		leveled_up.emit()
