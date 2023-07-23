extends Node2D


const CHILD_GOAL = 5
const LIVES = 3

const INITIAL_CHILD_SPAWN_TIME := 1.5
const CHILD_SPAWN_TIME := 25

var successful_children = 0
var dead_children = 0

var spawned_children = 0

onready var child_spawner = $YSort/ChildSpawner

enum SCREEN {
	HELP
	GAMEPLAY,
	PAUSE,
	END
}

var screen = SCREEN.GAMEPLAY


func _ready():
	randomize()
	start()

func start():
	$ChildSpawnTimer.start(INITIAL_CHILD_SPAWN_TIME)

func _process(delta):
	print_debug(successful_children)

func _on_ChildSpawnTimer_timeout():
	
	child_spawner.start()
	spawned_children += 1
	
	if spawned_children < CHILD_GOAL:
		$ChildSpawnTimer.start(CHILD_SPAWN_TIME)

func child_success():
	successful_children += 1
	check_game_over()

func child_death():
	dead_children += 1
	check_game_over()

func check_game_over():
	if dead_children + successful_children >= CHILD_GOAL:
		screen = SCREEN.END
		$EndScreen.alive_stats = successful_children
		$EndScreen.dead_stats = dead_children
		$EndScreen.activate()




func _input(event):
	if event.is_action_pressed("pause") and (screen == SCREEN.GAMEPLAY or screen == SCREEN.PAUSE):
		$PauseMenu.toggle_pause()
	if event.is_action_pressed("restart"):
		get_tree().paused = false
