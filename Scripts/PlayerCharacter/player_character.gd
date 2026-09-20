extends CharacterBody3D

@onready var statistic_list: StatisticList = $StatisticList
@onready var player_main_state_engine: StateEngine = $StateEngine
@onready var grab_range_ray_cast_3d: RayCast3D = $Neck/Head/Camera3D/GrabRangeRayCast3D
@onready var head: Node3D = $Neck/Head
@onready var camera: Camera3D = $Neck/Head/Camera3D

#bobbing values
@export var frequency: float = 1.5
@export var amplitude: float = 0.1
var time: float = 0
#player values
var mouse_sensitivity := 0.003
var camera_rotation_x := 0.0

var is_in_air: bool = false:
	set(new_value):
		if new_value:
			print('jump')
			player_main_state_engine.transition_to_new_state("inairstateengine")
		else:
			print("landed")
			player_main_state_engine.transition_to_new_state("normalstateengine")
			statistic_list.set_value_of("jumpstaken", 0.0)
		is_in_air = new_value

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotation.x -= event.relative.y * mouse_sensitivity

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	
	#print(player_main_state_engine.get_current_state_name())
	
	time += delta
	head.position.y = lerp(head.position.y, sin(time * frequency) * amplitude, 0.1)

	
	statistic_list.set_value_of("inputdirection", Input.get_vector("move_left", "move_right", "move_up", "move_down"))
	statistic_list.set_value_of("movementdirection",(transform.basis * Vector3(statistic_list.get_value_of("inputdirection").x, 0, statistic_list.get_value_of("inputdirection").y)).normalized() + Vector3(0, statistic_list.get_value_of("movementdirection").y, 0))
	
	if statistic_list.get_value_of("jumpstaken") < statistic_list.get_value_of("jumpstaken", "maximum") and Input.is_action_just_pressed("jump"):
		print("a")
		statistic_list.change_value_of("jumpstaken", 1)
		statistic_list.change_value_of("movementdirection", Vector3(0, statistic_list.get_value_of("jumpheight"), 0))
		
	if not is_on_floor():
		statistic_list.change_value_of("movementdirection", Vector3(0, -0.1, 0))
		if is_in_air == false:
			is_in_air = true
	
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	if statistic_list.get_value_of("movementdirection") != Vector3.ZERO:
		velocity.x = statistic_list.get_value_of("movementdirection").x * statistic_list.get_value_of("movementspeed")
		velocity.y = statistic_list.get_value_of("movementdirection").y
		velocity.z = statistic_list.get_value_of("movementdirection").z * statistic_list.get_value_of("movementspeed")
	else:
		velocity.x = move_toward(velocity.x, 0, statistic_list.get_value_of("movementspeed"))
		velocity.z = move_toward(velocity.z, 0, statistic_list.get_value_of("movementspeed"))
	
	move_and_slide()
