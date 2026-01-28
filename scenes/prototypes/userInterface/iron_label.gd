class_name LabelIron
extends Label


func _ready() -> void:
	update_text()
	HandlerIron.ref.iron_created.connect(update_text)
	HandlerIron.ref.iron_consumed.connect(update_text)


func update_text(_quantity : int = -1) -> void:
	text = "Iron : %s" %HandlerIron.ref.iron()
