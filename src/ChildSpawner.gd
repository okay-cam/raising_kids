extends Node2D


const ChildResource = preload("res://src/Child.tscn")

func spawn_child():
	# add child
	var child = ChildResource.instance()
	
	var level = get_parent()
	
	# connect signal
	child.connect("success", level, "child_success")
	child.connect("dead", level, "child_death")
	
	get_parent().add_child(child)
