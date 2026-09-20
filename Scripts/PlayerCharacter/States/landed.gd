extends State

func enter() -> void:

	
	await create_tween().tween_property(context.head, "position:y", clamp(0.1 * ($"../Falling".velocity_before_landing/20), -0.1, -0.5), 0.05).from_current().finished
	context.is_in_air = false
