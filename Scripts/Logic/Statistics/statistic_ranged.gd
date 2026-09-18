@tool
class_name StatisticRanged extends Statistic

var locked: bool

func _get_range_min():
	return null

func _get_range_max():
	return null

func _clamp_to_range(value):
	if check_limits:
		return clamp(value, _get_range_min(), _get_range_max())
	return value

func _build_range_editor_values(value_type: int) -> Array:
	var new_editor_values: Array

	if check_limits:
		new_editor_values.append({
			"name": &"minimum_statistic_value",
			"type": value_type,
			"usage": PROPERTY_USAGE_DEFAULT,
		})
		new_editor_values.append({
			"name": &"maximum_statistic_value",
			"type": value_type,
			"usage": PROPERTY_USAGE_DEFAULT,
		})

	new_editor_values.append({
		"name": &"locked",
		"type": TYPE_BOOL,
		"usage": PROPERTY_USAGE_DEFAULT,
	})

	return new_editor_values
