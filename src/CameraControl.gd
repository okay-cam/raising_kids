extends Camera2D
var lower_limit_x = -640
var upper_limit_x = 640

# !! how to code camera to stay within bounds but allow mouse movement

# !! camera position should be difference
# between player position and mouse




func _physics_process(_delta):
	pass
	
#	var mouse_offset = (get_viewport().get_mouse_position() - get_viewport().size/2) / 2.5
#	var extended_position = position + mouse_offset
#	if extended_position.x > lower_limit.x:
#		offset.x = extended_position.x - mouse_offset.x
#	else:
#		offset.x = mouse_offset.x
	
