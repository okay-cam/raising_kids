extends Node2D

export var spawn_offset := Vector2(0, 100)

const ChildResource = preload("res://src/Child.tscn")

# first open door & run timer to spawn child
# spawn child and run timer to close door
# close door

func _ready():
	$Sprite.play("closed")

func start():
	$Sprite.play("open")
	$SpawnChild.start()

func _on_SpawnChild_timeout():
	# add child
	var child = ChildResource.instance()
	
	child.position = position + spawn_offset
	
	var level = get_parent()
	
	# connect signal
	child.connect("success", level, "child_success")
	child.connect("dead", level, "child_death")
	
	get_parent().add_child(child)
	
	$CloseDoor.start()


func _on_CloseDoor_timeout():
	$Sprite.play("closed")
