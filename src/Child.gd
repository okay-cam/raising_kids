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
	WALK,
	REQUEST
}
var state := WALK


# ITEMS
enum {
	NONE = 0,
	WATER,
	FOOD,
	KEYS
}


# REQUESTS

# time between requests !!unused atm
const CHILL_TIME := 8.0
# time to complete request
const SERVE_TIME := 5.0

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

# SPEEDS

enum {
	NORMAL,
	HIT,
	ZOOMIES
}

# normal speed (other items might be hit speed, zoomies speed, etc)
const BABY_SPEED = [0.0]
const KID_SPEED = [3.0]

# speed when hit
const HIT_SPEED := 25.0
# go to fast speed after eating an item (just kids)
const ZOOMIES_SPEED := 8.0
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
	speed_goal = get_speed(NORMAL)

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
	
	# face left when moving left
	if state == WALK:
		do_walk_animation()
		$Sprite.flip_h = direction.x < 0
	
	if state == REQUEST:
		do_request_animation()
		$Sprite.flip_h = false
		
		# patience runs out after SERVE_TIME seconds
		$Patience.value -= (100.0 / SERVE_TIME) * delta
		
		var value = $Patience.value
		
		# go from green to red over time
#		$Patience.tint_progress.h = clamp(range_lerp(value, 0, 100, 0 - 20, 120 + 20), 0, 120)
		$Patience.tint_progress.h = range_lerp(value, 0, 100, 0, 1)
		
		print("val")
		print(value)
		print("patience tint")
		print($Patience.tint_progress.h)
		
	
	


func get_speed(type):
	match age:
		BABY:
			return BABY_SPEED[type]
		KID:
			return KID_SPEED[type]


func _on_ZoomiesCooldown_timeout():
	speed_goal = get_speed(NORMAL)



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
	
	if age == KID:
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
	if request_bag.size() <= 0:
		print_debug("ran out of requests")
		return
	
	state = REQUEST
	
	# choose from request bag
	current_request = request_bag.pop_at(randi() % len(request_bag))
	
	# show request
	$RequestIcon.show()
	$RequestIcon.frame = current_request
	$Patience.show()
	$Patience.value = 100
	
	# change sprite animation to requesting
	do_request_animation()


func do_request_animation():
	$Sprite.animation = str(age) + "Request"
func do_walk_animation():
	$Sprite.animation = str(age) + "Walk"

func remove_request():
	state = WALK
	$RequestIcon.hide()
	$Patience.hide()
	
	$StartRequest.stop()

func _on_StartRequest_timeout():
	generate_request()

