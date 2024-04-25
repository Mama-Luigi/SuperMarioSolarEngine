class_name GroundPoundCancel
extends Fall
## Pressing up after a groundpound.


func _trans_rules():
	if movement.can_spin() and input.buffered_input(&"spin"):
		return &"Twirl"

	if not movement.dived and input.buffered_input(&"dive") and movement.can_air_action():
		if Input.is_action_pressed(&"down"):
			return [&"FaceplantDive", 0.0]
		else:
			return [&"Dive", false]

	if Input.is_action_just_pressed(&"down") and movement.can_air_action():
		return &"GroundPound"

	if movement.can_init_wallslide():
		return &"Wallslide"

	if movement.finished_freefall_timer():
		return &"Freefall"

	return &""
