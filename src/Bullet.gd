extends KinematicBody2D

const INIT_SPEED := 1000
const DECELERATE_LERP := 0.02

var velocity := Vector2.ZERO

var item := 0

func init(init_item, init_pos, init_ang):
	set_item(init_item)
	
	position = init_pos
	velocity = Vector2.RIGHT.rotated(init_ang) * INIT_SPEED


func _physics_process(delta):
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		# set new velocity
		velocity = velocity.bounce(collision.normal)
		# reduce velocity from bounce
		velocity /= 2
	
	#	# slow down over time
#	velocity = velocity.linear_interpolate(Vector2.ZERO, DECELERATE_LERP)


func set_item(new_item):
	item = new_item
	$Sprite.frame = item

# ran from child when item is being taken
func take():
	queue_free()

func _on_Delete_timeout():
	queue_free()
