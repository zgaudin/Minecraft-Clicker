class_name HandlerIronUpgrades
extends Node

#singleton reference
static var ref : HandlerIronUpgrades

#singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()


signal upgrade_leveled_up(upgrade : Upgrade)

##@onready var u_01_gold_generation : IronUpgrade01GoldGenerator = IronUpgrade01GoldGenerator.new()

func get_all_uprades() -> Array[Upgrade]:
	return [
		##u_01_gold_generation,
	]
