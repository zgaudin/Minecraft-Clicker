class_name LabelGold
extends Label


func _ready() -> void:
	update_text()
	HandlerGold.ref.gold_created.connect(update_text)
	HandlerGold.ref.gold_consumed.connect(update_text)


func update_text(_quantity : int = -1) -> void:
	text = "Gold : %s" %HandlerGold.ref.gold()
