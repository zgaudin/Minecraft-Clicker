class_name Upgrade03GeneratorUpgrade
extends Upgrade
## Upgrade 01 - Increases gold each Second

## Load level data
func _init() -> void:
	level = Game.ref.data.up_03_levelG
	title = "Diamond Leggings and Boots"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var description : String = "Increases diamond obtained each second."
	description += "\nEffects : +1 Diamond per Second / Level"
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
		Game.ref.data.up_03_levelG = level
		
		calculate_cost()
		
		leveled_up.emit()
