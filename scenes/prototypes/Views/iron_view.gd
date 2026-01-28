class_name ViewIron
extends View

@export var ironu_area : Control

@export var compo_upgrade_scene : PackedScene

func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()


func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade] = HandlerIronUpgrades.ref.get_all_uprades()
	
	if upgrades.size() == 0:
		return
	
	for upgrade : Upgrade in upgrades:
		var upgrade_node : CompoUpgrade = compo_upgrade_scene.instantiate() as CompoUpgrade
	 
		upgrade_node.upgrade = upgrade
		
		ironu_area.add_child(upgrade_node)
