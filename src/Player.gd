extends KinematicBody2D


const SPEED := 400

var velocity := Vector2.ZERO

func _physics_process(delta):
	
	var input : Vector2
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	input = input.normalized()
	
	velocity = input * SPEED
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_pressed("click"):
		shoot()


func shoot():
	pass
	
#	$ShootCooldown.start()
#
#	var bullet = BulletScene.instance()
#	bullet.init(position, get_local_mouse_position().angle())
#	get_parent().add_child(bullet)

