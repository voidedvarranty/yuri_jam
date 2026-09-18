@tool
class_name StatisticBool extends Statistic

@export_group("statistic value")
@export var statistic_value: bool : set = _set_statistic_value

var forced_bool_value: bool

func _set_statistic_value(new_value: bool) -> void:
	var old_value: bool = statistic_value

	var resolved_value: bool = forced_bool_value if check_limits else new_value

	statistic_value = resolved_value

	if old_value != resolved_value:
		statistic_changed.emit(old_value, resolved_value)

func set_new_editor_values() -> Array:
	if check_limits:
		return [{
			"name": &"forced_bool_value",
			"type": TYPE_BOOL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"prefix": "statistic",
		}]

	return []
