extends Node2D


const CHILD_GOAL = 5
const LIVES = 3

const INITIAL_CHILD_SPAWN_TIME := 1.5
const CHILD_SPAWN_TIME := 20

var successful_children = 0
var dead_children = 0

var spawned_children = 0



func _ready():
	start()

func start():
	$ChildSpawnTimer.start(INITIAL_CHILD_SPAWN_TIME)

func _on_ChildSpawnTimer_timeout():
	
	$ChildSpawner.spawn_child()
	spawned_children += 1
	
	if spawned_children < CHILD_GOAL:
		$ChildSpawnTimer.start(CHILD_SPAWN_TIME)

func child_success():
	successful_children += 1
	
	# !! game win if 5

func child_death():
	successful_children += 1
	
	# !! add game loss
	pass

