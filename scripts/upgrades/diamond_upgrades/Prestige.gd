class_name Prestige
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.prestige
	title = "Win"
	base_cost = 500000
	calculate_cost()

func description() -> String:
	var description : String = "Win"
	description += "\nEffects : Win"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(10, level))



func can_afford() -> bool:
	if HandlerDiamond.ref.diamond() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	if Game.ref.data.prestige == 1:
		return
	var error : Error = HandlerDiamond.ref.consume_diamond(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_01_Win = level

		
		calculate_cost()
		
		leveled_up.emit()
