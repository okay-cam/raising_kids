extends KinematicBody2D

const INIT_SPEED := 250
const DECELERATE_LERP := 0.2

var velocity := Vector2.ZERO


func init(init_pos, init_ang):
	position = init_pos
	
	velocity = Vector2.RIGHT.rotated(init_ang) * INIT_SPEED


func _physics_process(delta):
	
	velocity = move_and_slide(velocity)


