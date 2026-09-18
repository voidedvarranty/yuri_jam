extends State

func enter() -> void:
	await context.ready
	context.animation_player.play("IDLE")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if context.statistic_list.get_value_of("inputdirection") != Vector2.ZERO:
		transitioned.emit("walking")
