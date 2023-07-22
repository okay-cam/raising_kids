extends Node2D


const CHILD_GOAL = 5

var successful_children = 0

var spawned_children = 0

func _ready():
	
	$ChildSpawnTimer.start()



func _on_ChildSpawnTimer_timeout():
	
	$ChildSpawner.spawn_child()
	spawned_children += 1
	
	if spawned_children < CHILD_GOAL:
		$ChildSpawner.start()
	
