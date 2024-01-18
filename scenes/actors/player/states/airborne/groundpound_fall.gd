class_name GroundPoundFall
extends PlayerState
## Falling after performing a ground pound.


## How fast you ground pound.
@export var gp_fall_vel = 9


func _cycle_tick():
	movement.move_x(0.04, false)
	actor.vel.y = gp_fall_vel


func _tell_switch():
	if actor.is_on_floor():
		return &"GroundPoundLand"

	if movement.can_air_action() and input.buffered_input(&"dive"):
		return &"AirborneDive"

	if input.buffered_input(&"up"):
		return &"GroundPoundCancel"

	return &""
