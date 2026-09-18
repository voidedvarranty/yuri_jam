extends CharacterBody3D

@onready var statistic_list: StatisticList = $StatisticList
@onready var camera: Camera3D = $Camera3D
@onready var player_main_state_engine: StateEngine = $StateEngine



var is_in_air: bool = false:
	set(new_value):
		if new_value:
			player_main_state_engine.transition_to_new_state("inairstateengine")
		is_in_air = new_value

var mouse_sensitivity := 0.003
var camera_rotation_x := 0.0
var speed := 5.0
var gravity := 9.8

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotation.x -= event.relative.y * mouse_sensitivity

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	#print(transform.basis, "\n", statistic_list.get_value_of("movementdirection"), "\n", is_on_floor())
	
	statistic_list.set_value_of("inputdirection", Input.get_vector("move_left", "move_right", "move_up", "move_down"))
	statistic_list.set_value_of("movementdirection",(transform.basis * Vector3(statistic_list.get_value_of("inputdirection").x, 0, statistic_list.get_value_of("inputdirection").y)).normalized() + Vector3(0, statistic_list.get_value_of("movementdirection").y, 0))
	
	if statistic_list.get_value_of("howmanyjumpsucantake") > 0 and Input.is_action_just_pressed("jump"):
		statistic_list.change_value_of("howmanyjumpsucantake", -1)
		statistic_list.change_value_of("movementdirection", Vector3(0, statistic_list.get_value_of("jumpheight"), 0))
		
	if not is_on_floor():
		statistic_list.change_value_of("movementdirection", Vector3(0, -0.1, 0))
		if is_in_air == false:
			is_in_air == true
	
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	if statistic_list.get_value_of("movementdirection") != Vector3.ZERO:
		velocity.x = statistic_list.get_value_of("movementdirection").x * statistic_list.get_value_of("movementspeed")
		velocity.y = statistic_list.get_value_of("movementdirection").y
		velocity.z = statistic_list.get_value_of("movementdirection").z * statistic_list.get_value_of("movementspeed")
	else:
		velocity.x = move_toward(velocity.x, 0, statistic_list.get_value_of("movementspeed"))
		velocity.z = move_toward(velocity.z, 0, statistic_list.get_value_of("movementspeed"))
		
	
	
	move_and_slide()
