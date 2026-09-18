extends Node
class_name StatisticList

var statistics: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Statistic:
			statistics[child.get_lookup_id()] = child

func _get_stat(statistic_name: String) -> Statistic:
	if not statistics.has(statistic_name):
		push_error("StatisticList: unknown statistic '%s'" % statistic_name)
		return null
	return statistics[statistic_name]

func get_value_of(statistic_name: String, value_type: String = "current"):
	var stat := _get_stat(statistic_name)
	if stat == null:
		return null

	if value_type in ["maximum", "minimum"] and not ("maximum_statistic_value" in stat):
		push_error("StatisticList: '%s' has no min/max range" % statistic_name)
		return null

	match value_type:
		"maximum": return stat.maximum_statistic_value
		"minimum": return stat.minimum_statistic_value
		_: return stat.statistic_value

## Only meaningful for numeric statistics.
func change_value_of(statistic_name: String, change) -> void:
	var stat := _get_stat(statistic_name)
	if stat == null:
		return

	#if not (stat is StatisticNumber):
		#push_error("StatisticList: change_value_of only supports StatisticNumber ('%s' is %s)" % [statistic_name, stat.get_class()])
		#return

	stat.statistic_value += change

## value_type = "exact" (default) sets statistic_value directly.
## value_type = "maximum" / "minimum" snaps the stat to its own range bound.
func set_value_of(statistic_name: String, value = null, value_type: String = "exact") -> void:
	var stat := _get_stat(statistic_name)
	if stat == null:
		return

	if value_type in ["maximum", "minimum"] and not ("maximum_statistic_value" in stat):
		push_error("StatisticList: '%s' has no min/max range" % statistic_name)
		return

	match value_type:
		"maximum": stat.statistic_value = stat.maximum_statistic_value
		"minimum": stat.statistic_value = stat.minimum_statistic_value
		_: stat.statistic_value = value
