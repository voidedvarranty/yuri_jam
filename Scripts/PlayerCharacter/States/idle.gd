extends State

@export var bobbing_frequency: float = 0.0
@export var bobbing_amplitude: float = 0.0

func enter() -> void:
	context.frequency = bobbing_frequency
	context.amplitude = bobbing_amplitude

	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if context.statistic_list.get_value_of("inputdirection") != Vector2.ZERO:
		transitioned.emit("walking")
