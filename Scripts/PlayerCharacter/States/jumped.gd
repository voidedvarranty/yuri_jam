extends State

@export var bobbing_frequency: float = 0.0
@export var bobbing_amplitude: float = 0.0

func enter() -> void:
	context.frequency = bobbing_frequency
	context.amplitude = bobbing_amplitude
	
	if context.velocity.y <= 0.0:
		transitioned.emit("falling")
		return
	
	create_tween().tween_property(context.head, "position:y", 0.3, 0.1).from_current()
	
func physics_update(_delta: float) -> void:
	if context.velocity.y <= 0.0:
		transitioned.emit("falling")
