class_name Upgrade02ToolUpgrade
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_02_levelInterval
	title = "Iron Tools"
	base_cost = 500
	calculate_cost()

func description() -> String:
	var description : String = "Double iron from all sources."
	description += "\nEffects : *2 Iron"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(10, level))



func can_afford() -> bool:
	if HandlerIron.ref.iron() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	var error : Error = HandlerIron.ref.consume_iron(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_02_levelInterval = level

		
		calculate_cost()
		
		leveled_up.emit()
