class_name UpGoldReset
extends Upgrade
## Upgrade 01 - Increases gold each click

## Load level data
func _init() -> void:
	level = Game.ref.data.gold_reset_level
	title = "Iron Block"
	base_cost = 1000
	calculate_cost()

func description() -> String:
	var description : String = "Converts Gold to Iron and resets all Gold upgrades to 0"
	description += "\nEffects : 1000 Gold = 1 Iron"
	description += "\nCost : All Gold (At least 1000 needed)"
	
	return description


func calculate_cost() -> void:
	if can_afford():
		current_cost = Game.ref.data.gold



func can_afford() -> bool:
	if HandlerGold.ref.gold() >= 1000:
		
		return true
	
	return false


func level_up() -> void:
	if Game.ref.data.gold_reset_level == 1:
		return
		
	var error : Error = HandlerGold.ref.consume_gold(current_cost)
	
	if not error: 
		level += 1
		Game.ref.data.gold_reset_level = level
		
		## Resetting all Gold Levels
		
		calculate_cost()
		
		
		leveled_up.emit()
