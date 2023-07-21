extends KinematicBody2D

# AGE
enum {
	BABY = 1
	KID,
	TEEN,
	ADULT
}
# current age (BABY, KID, etc)
var age := BABY


# STATES
enum {
	DEAD = 0,
	
}

# ITEMS
enum {
	NONE = 0,
	WATER,
	FOOD,
	KEYS
}


# REQUESTS

# time between requests !!unused atm
const CHILL_TIME := 8
# time to complete request
const SERVE_TIME := 10

# stores all possible requests for that child
var request_bag = []
var current_request := NONE
# number of completed requests for current age
var completed_requests := 0


# MOVEMENT
# direction of movement
var direction := Vector2.RIGHT
var speed : float = 0
var speed_goal : float = 0

# SPEED
# normally go to this speed
const NORMAL_SPEED := 4.0
# speed when hit
const HIT_SPEED := 25.0
# go to fast speed after eating an item (!! for just babies?)
const ZOOMIES_SPEED := 16.0
const LERP_SPEED := 0.05

func _ready():
	
	init()
	start_moving()

func init():
	remove_request()
	refresh_request_bag()
	$StartRequest.start()

# MOVEMENT
func start_moving():
	speed_goal = NORMAL_SPEED

func _physics_process(delta):
	
	var velocity : Vector2 = direction * speed
	
	# lerp to goal speed
	speed = lerp(speed, speed_goal, LERP_SPEED)
	
	# MOVE & COLLIDE
	var collision := move_and_collide(velocity)
	
	if collision:
		# set new velocity
		direction = direction.bounce(collision.normal)
#		# some random rotation
#		direction = direction.rotated( rand_range( -PI / 0.2 , PI / 0.2 ))


func _on_ZoomiesCooldown_timeout():
	speed_goal = NORMAL_SPEED



# TAKING ITEMS
func _on_ItemArea_body_entered(body):
	var item = body.item
	
	# make child happy
	if item == current_request:
		completed_requests += 1
		remove_request()
		$StartRequest.start()
	
	# set child movement
	direction = body.velocity.normalized()
	
	speed = HIT_SPEED
	speed_goal = ZOOMIES_SPEED
	$ZoomiesCooldown.start()
	
	# remove item
	body.take()





# REQUESTS

# put possible requests in list depending on age
func refresh_request_bag():
	match age:
		BABY:
			request_bag = [WATER, FOOD]
#			request_bag = [WATER, FOOD, KEYS]
		KID:
			request_bag = [WATER, FOOD]
		TEEN:
			request_bag = [WATER, FOOD]
		ADULT:
			request_bag = [KEYS]

# give child a request
func generate_request():
	# choose from request bag
	current_request = request_bag.pop_at(randi() % len(request_bag))
	
	# show request
	$RequestIcon.show()
	$RequestIcon.frame = current_request
	
	# change sprite animation to requesting
	request_animation()

func request_animation():
	$Sprite.animation = str(age) + "Request"

func walk_animation():
	$Sprite.animation = str(age) + "Walk"

func remove_request():
	$RequestIcon.hide()
	$StartRequest.stop()

func _on_StartRequest_timeout():
	generate_request()

