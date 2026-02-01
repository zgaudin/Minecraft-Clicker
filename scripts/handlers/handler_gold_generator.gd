class_name HandlerGoldGenerator
extends Node
## Passively Generates Gold

static var ref : HandlerGoldGenerator

#singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
		
	queue_free()

@export var timer : Timer


	##HandlerIronUpgrades.ref.upgrade_leveled_up.connect(watch_for_upgrades_level_up)


func _on_timer_timeout() -> void:
	HandlerGold.ref.create_gold(1)

func watch_for_upgrades_level_up(upgrade : Upgrade) -> void:
	if upgrade == HandlerIronUpgrades.ref.u_01_gold_generation_level:
		timer.start()
		HandlerIronUpgrades.ref.upgrade_leveled_up.disconnect(watch_for_upgrades_level_up)
