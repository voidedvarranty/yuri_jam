@tool
class_name StatisticVectorDDD extends StatisticRanged

@export_group("statistic properties")
@export var statistic_value: Vector3 : set = _set_statistic_value

var minimum_statistic_value: Vector3
var maximum_statistic_value: Vector3

func _get_range_min():
	return minimum_statistic_value

func _get_range_max():
	return maximum_statistic_value

func _set_statistic_value(new_value: Vector3) -> void:
	if locked:
		return

	var old_value: Vector3 = statistic_value
	new_value = _clamp_to_range(new_value)
	statistic_value = new_value

	if old_value != new_value:
		statistic_changed.emit(old_value, new_value)

func set_new_editor_values() -> Array:
	return _build_range_editor_values(TYPE_VECTOR3)
