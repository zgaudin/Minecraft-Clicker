class_name LabelDiamond
extends Label


func _ready() -> void:
	update_text()
	HandlerDiamond.ref.diamond_created.connect(update_text)
	HandlerDiamond.ref.diamond_consumed.connect(update_text)


func update_text(_quantity : int = -1) -> void:
	text = "Diamond : %s" %HandlerDiamond.ref.diamond()
