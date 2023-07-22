extends KinematicBody2D

onready var request_icon = $Patience/Icon

# !!
# the player should always move at their normal speed


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

# number of requests until aging (except adult)
const TOTAL_REQUESTS := 2
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
const KID_SPEED = [4.0]
const TEEN_SPEED = [6.0]
const ADULT_SPEED = [7.0]

# speed when hit
const HIT_SPEED := 25.0
# go to fast speed after eating an item (just kids)
const ZOOMIES_SPEED := 8.0
const LERP_SPEED := 0.05

func _ready():
	refresh_normal_speed()
	init()

func init():
	remove_request()
	refresh_request_bag()
	$StartRequest.start()

# MOVEMENT
func refresh_normal_speed():
	speed_goal = get_speed(NORMAL)

func _physics_process(delta):
	
	print(state)
	
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
		
		var value : float = $Patience.value
		
		# go from green to red over time
		$Patience.tint_progress.h = clamp(range_lerp(value, 0, 100, 0 - 0.1, 1/3.0 + 0.1), 0, 1/3.0)
		
		# DIE
		if value <= 0:
			state = DEAD
			$Sprite.animation = "Dead"
			remove_request()
			refresh_normal_speed()
		
#		print("val")
#		print(value)
#		print("patience tint")
#		print($Patience.tint_progress.h)
		
	
	


func get_speed(type):
	
	if state == DEAD:
		return 0
	
	match age:
		BABY:
			return BABY_SPEED[type]
		KID:
			return KID_SPEED[type]
		TEEN:
			return TEEN_SPEED[type]
		ADULT:
			return ADULT_SPEED[type]


func _on_ZoomiesCooldown_timeout():
	refresh_normal_speed()



# TAKING ITEMS
func _on_ItemArea_body_entered(body):
	var item = body.item
	
	# HOLDS CORRECT ITEM
	if item == current_request:
		completed_requests += 1
		$Patience.value = 100
		remove_request()
		
		# remove adult when given keys
		if age == ADULT:
			# !! fade away later to leave
			queue_free()
		
		if age != ADULT:
			# start new request
			$StartRequest.start()
			
			# walk around again
			state = WALK
			
			# increase age after all requests
			if completed_requests >= TOTAL_REQUESTS:
				increase_age()
	
	# DO THIS CODE REGARDLESS OF CORRECT ITEM
	
	# set child movement
	direction = body.velocity.normalized()
	
	speed = HIT_SPEED
	
	# !! zoomies
#	if age == KID:
#		speed_goal = ZOOMIES_SPEED
#		$ZoomiesCooldown.start()
	
	# remove item
	body.take()


# AGING

func increase_age():
	age += 1
	completed_requests = 0
	refresh_normal_speed()


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
		refresh_request_bag()
	
	state = REQUEST
	
	# choose from request bag
	current_request = request_bag.pop_at(randi() % len(request_bag))
	
	# show request
	request_icon.show()
	request_icon.frame = current_request
	$Patience.show()
	$Patience.value = 100
	$Patience.tint_progress.h = 0.333
	
	# change sprite animation to requesting
	do_request_animation()


func do_request_animation():
	if state == DEAD:
		return
	$Sprite.animation = str(age) + "Request"
func do_walk_animation():
	if state == DEAD:
		return
	$Sprite.animation = str(age) + "Walk"

func remove_request():
	current_request = NONE
	request_icon.hide()
	$Patience.hide()
	
	$StartRequest.stop()

func _on_StartRequest_timeout():
	generate_request()

