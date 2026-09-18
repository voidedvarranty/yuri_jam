@tool
extends Node
class_name Statistic

signal statistic_changed(old_value, new_value)

@export_category("statistic properties")
@export var stat_id: StringName
@export var check_limits: bool : set = set_check_limits_value

func set_check_limits_value(new_value) -> void:
	check_limits = new_value
	notify_property_list_changed()
	
func get_lookup_id() -> StringName:
	if stat_id != &"":
		return stat_id
	return StringName(name.to_lower())

func set_new_editor_values() -> Array:
	return []

func _get_property_list() -> Array:
	return set_new_editor_values()
