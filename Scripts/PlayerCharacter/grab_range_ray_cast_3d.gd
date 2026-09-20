extends RayCast3D

@export var pickup_point: Marker3D
var currently_picked_up_object: RigidBody3D

func _process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("action_primary"):
		
		if currently_picked_up_object != null:
			currently_picked_up_object.freez = false
			currently_picked_up_object.sleep = false
			currently_picked_up_object.lock = false
			
		var object_in_front = get_collider()
		if object_in_front.is_in_group("CanBePickedUp"):
			object_in_front.freez = true
			object_in_front.sleep = true
			object_in_front.lock = true
			
			
