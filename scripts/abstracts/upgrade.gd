class_name Upgrade
extends Node
## Abstract class defining Upgrade

signal leveled_up

var level : int = -1

var title : String = "Title Not Defined"
var base_cost : int = -1
var current_cost : int = -1

## Virtual class, must be overwritten.[br]
## Returns description of upgrade
func description() -> String:
	return "Description not defined"

## Virtual class, must be overwritten.[br]
func calculate_cost() -> void:
	printerr("calculate_cost() method not defined.")

## Virtual class, must be overwritten.[br]
func can_afford() -> bool:
	return false

## Virtual class, mus tbe overwritten.[br]
func level_up() -> void:
	printerr("level_up() method not defined")
