class_name UnlockDiamond
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.up_01_unlockDiamond
	title = "Diamond Block"
	base_cost = 50000
	calculate_cost()

func description() -> String:
	var description : String = "Unlock Diamond"
	description += "\nEffects : Unlock Diamond"
	description += "\nCost : %s" %current_cost
	
	return description

func calculate_cost() -> void:
	current_cost = int(base_cost * pow(10, level))



func can_afford() -> bool:
	if HandlerIron.ref.iron() >= current_cost:
		return true
	
	return false


func level_up() -> void:
	if Game.ref.data.up_01_unlockDiamond == 1:
		return
	var error : Error = HandlerIron.ref.consume_iron(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.up_01_unlockDiamond = level

		
		calculate_cost()
		
		leveled_up.emit()
